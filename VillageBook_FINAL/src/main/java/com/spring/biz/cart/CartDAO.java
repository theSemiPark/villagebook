package com.spring.biz.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.biz.common.JDBCUtil;

@Repository("cartDAO")
public class CartDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	private ResultSet rs2 = null;
	
	private final String CART_CHECK = "SELECT * FROM CART WHERE cid = ? and lid = ? and isbn = ?";
	private final String CART_SAME = "update cart set cnt = cnt+1 where cartid = ?";
	private final String CART_INSERT = "insert into cart values (cart_id.nextval, ?, ?, ?, ?, ?, ?, SYSDATE)";
	private final String CART_UPDATE = "update cart set cnt = ? where cartid = ?";
	private final String CART_DELETE = "delete from cart where cartid = ?";
	private final String CART_GET = "select * from cart where cid = ? order by lid";
	private final String CART_LID = "select distinct lid from cart where cid = ?";
	private final String LLOGIN_CHECK = "select * from library where llogin = 0 and lid = ?";
	private final String BOOK_CHECK = "select * from cart where cid = ?";
	private final String RENTAL_CHECK = "select * from rental, book where rental.isbn = ? and rental.lid = ? and rental.isbn = book.isbn and rental.havecnt - rental.rcnt < ?";
	private final String CHECK_RESERVE = "select reserve.*, book.bookname from reserve, book where reserve.isbn = ? and lid = ? and cid = ? and revrank = 0 and reserve.isbn = book.isbn";
	public void insertCart(CartVO vo) {
		System.out.println("===> JDBC로 insertCart() 기능처리");
		try {
			conn = JDBCUtil.getConnection();
			
			stmt = conn.prepareStatement(CART_CHECK);
			stmt.setString(1,  vo.getcId());
			stmt.setString(2,  vo.getlId());
			stmt.setLong(3, vo.getIsbn());
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				stmt = conn.prepareStatement(CART_SAME);
				stmt.setLong(1, rs.getLong("cartid"));
				stmt.executeUpdate();
			} else {
				stmt = conn.prepareStatement(CART_INSERT);
				stmt.setInt(1, 1);
				stmt.setString(2,  vo.getBookname());
				stmt.setString(3, vo.getlId());
				stmt.setString(4, vo.getLname());
				stmt.setLong(5, vo.getIsbn());
				stmt.setString(6, vo.getcId());
				stmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}
	
	public void updateCart(CartVO vo) {
		System.out.println("===> JDBC로 updateCart() 기능처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(CART_UPDATE);
			stmt.setInt(1, vo.getCnt());
			stmt.setInt(2, vo.getCartId());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}
	
	public void deleteCart(CartVO vo) {
		System.out.println("===> JDBC로 deleteCart() 기능처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(CART_DELETE);
			stmt.setLong(1, vo.getCartId());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}
	public List<CartVO> getCart(CartVO vo) {
		System.out.println("===> JDBC로 getCart() 기능처리");
		List<CartVO> cartList = new ArrayList<CartVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(CART_GET);
			stmt.setString(1, vo.getcId());

			rs = stmt.executeQuery();
			while (rs.next()) {
				CartVO cart = new CartVO();
				cart.setCartId(rs.getInt("CARTID"));
				cart.setCnt(rs.getInt("CNT"));
				cart.setBookname(rs.getString("BOOKNAME"));
				cart.setlId(rs.getString("LID"));
				cart.setLname(rs.getString("LNAME"));
				cart.setIsbn(rs.getLong("ISBN"));
				cart.setcId(rs.getString("CID"));
				cartList.add(cart);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return cartList;
	}

	public String checkCart(CartVO vo) {

		System.out.println("===> JDBC로 checkCart() 기능처리");
		
		String check = "";
		String rest = "";
		String book = "";
		String rev = "";
	
		List<String> lidList = new ArrayList<String>();
		List<StockVO> checkList= new ArrayList<StockVO>();
		
		try {
			conn = JDBCUtil.getConnection();
			
			//도서관 운영여부 확인
			stmt = conn.prepareStatement(CART_LID);
			stmt.setString(1, vo.getcId());

			rs = stmt.executeQuery();
			while (rs.next()) lidList.add(rs.getString("LID"));
			
			for(String lid : lidList) {
				stmt = conn.prepareStatement(LLOGIN_CHECK);
				stmt.setString(1, lid);
				rs = stmt.executeQuery();
				if(rs.next()) {
					if (rest == "") rest = rs.getString("lname");
					else rest += ", " + rs.getString("lname");
				}
			}
			
			if(rest != "") rest += "의 운영시간이 아닙니다.";
			
			// 도서 재고 확인
			stmt = conn.prepareStatement(BOOK_CHECK);
			stmt.setString(1, vo.getcId());
			
			rs = stmt.executeQuery();

			while(rs.next()) {
				StockVO a = new StockVO();
				a.setIsbn(rs.getLong("isbn"));
				a.setLid(rs.getString("lid"));
				a.setCnt(rs.getInt("cnt"));
				checkList.add(a);
			}
			
			for(StockVO a : checkList) {
				stmt = conn.prepareStatement(RENTAL_CHECK);
				stmt.setLong(1, a.getIsbn());
				stmt.setString(2, a.getLid());
				stmt.setInt(3, a.getCnt());
				rs = stmt.executeQuery();
				
				if(rs.next()) {
					stmt = conn.prepareStatement(CHECK_RESERVE);
					stmt.setLong(1, a.getIsbn());
					stmt.setString(2, a.getLid());
					stmt.setString(3, vo.getcId());
					rs2 = stmt.executeQuery();
					if(rs2.next()) {
						if(a.getCnt() > 1) {
							if(rev.equals("")) rev = rs2.getString("bookname");
							else rev += ", " + rs2.getString("bookname");
						}
					} else {
						if(book.equals("")) book = "'" + rs.getString("bookname") + "'";
						else book += ", '" + rs.getString("bookname") + "'";
					}
				}
			}
			
			if(!book.equals("")) book += "의 재고가 부족합니다.";
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		
		if(!book.equals("") && !rest.equals("")) check = rest + "\n" + book;
		else check = rest + book;
		if(!rev.equals("")) rev = "예약 도서(" + rev + ")는 한 권 씩만 대출할 수 있습니다.";
		
		if(!check.equals("") && !rev.equals("")) {
			check += "\n" + rev;
		} else check += rev;
		
		return check;
	}
}