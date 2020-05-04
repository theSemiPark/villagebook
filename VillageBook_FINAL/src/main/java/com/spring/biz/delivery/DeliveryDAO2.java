package com.spring.biz.delivery;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import com.spring.biz.common.JDBCUtil;

public class DeliveryDAO2 {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	private final String RENE_CHANGE = "update delivery set renewtf='Y' where ordid = ? and lid = ?";
	private final String CHANGE_DATE = "update delivery set RETURNDATE = RETURNDATE+7 where ordid = ? and lid = ?";
	private final String WHAT_RETURN = "select * from delivery where ordid = ? and lid = ?";
	private final String BOOK_RETURN = "update delivery set returnwer='R' where ordid = ? and lid = ?";
	private final String BOOK_RETURN2 = "update delivery set returnwer='Y', returndate = sysdate where ordid = ? and lid = ?";
	private final String RETURN_MESSAGE = "insert into message values (m_seq.nextval, ?, 'server', ?, null, sysdate)";
	private final String RENTAL_BACK = "update rental set rcnt = rcnt - ? where isbn = ? and lid = ?";
	private final String RESERVE_CHECK = "select count(*) from reserve where lid = ? and isbn = ?";
	private final String RESERVE_UPDATE = "update reserve set revrank = 0 where lid = ? and isbn = ? and revrank <= ?";
	private final String RESERVE_0RANK = "select cid from reserve where revrank = 0 and lid = ? and isbn = ?";
	private final String RESERVE_MESSAGE = "insert into message values (m_seq.nextval, ?, 'server', ?, null, sysdate)";
	private final String LATE_FEE = "insert into point values (pid_seq.nextval, ?, 2, 0, ?)";
	private final String MINUS_FEE = "update user_info set cpoint = cpoint - ? where cid = ?";
	private final String RETURN_LIST = "select distinct ordid, cid, returndate from delivery where returnwer = 'R' and lid = ?";
	private final String RETURN_DETAIL = "select * from delivery where ordid = ? and lid = ?";
	
	private final String NEW_ORDER = "select * from (select distinct ordid, cid, orderdate, ordmoney from delivery order by ordid desc) where rownum <= 10";
	
	public void getchange(DeliveryVO vo) {
		System.out.println("===> JDBC DeliveryDAO getchange()");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(RENE_CHANGE);
			stmt.setLong(1, vo.getOrdid());
			stmt.setString(2, vo.getLid());
			System.out.println(vo.getOrdid());
			rs = stmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}
	
	public void getchange_DATE(DeliveryVO vo) {
		System.out.println("===> JDBC DeliveryDAO getcahnge_DATE()");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(CHANGE_DATE);
			stmt.setLong(1, vo.getOrdid());
			stmt.setString(2, vo.getLid());
			rs = stmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}

	// User Mode에서 returnwer 'N' -> 'R'
	public void bookReturn1(DeliveryVO vo) {
		System.out.println("===> JDBC DeliveryDAO bookReturn");
		try {
			conn = JDBCUtil.getConnection();		
			// delivery에서 반납요청 처리
			stmt = conn.prepareStatement(BOOK_RETURN);
			stmt.setLong(1, vo.getOrdid());
			stmt.setString(2, vo.getLid());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}
	
	// Library Mode에서 returnwer 'R' -> 'Y'
	public void bookReturn2(DeliveryVO vo) {
		System.out.println("===> JDBC DeliveryDAO bookReturn");
		List<DeliveryVO> bookList = new ArrayList<DeliveryVO>();
		Date returndate = null;
		java.util.Date utilDate = new java.util.Date();
	    Date today = new Date(utilDate.getTime());
		try {
			conn = JDBCUtil.getConnection();
			
			// 반납할 도서목록 가져오기
			stmt = conn.prepareStatement(WHAT_RETURN);
			stmt.setLong(1, vo.getOrdid());
			stmt.setString(2, vo.getLid());
			rs = stmt.executeQuery();
			while(rs.next()) {
				DeliveryVO book = new DeliveryVO();
				book.setIsbn(rs.getLong("isbn"));
				book.setBookname(rs.getString("bookname"));
				book.setLid(rs.getString("lid"));
				book.setOrdercnt(rs.getLong("ordercnt"));
				bookList.add(book);
				if(returndate == null) returndate = rs.getDate("returndate");
			}
			
			// delivery에서 반납 처리
			stmt = conn.prepareStatement(BOOK_RETURN2);
			stmt.setLong(1, vo.getOrdid());
			stmt.setString(2, vo.getLid());
			stmt.executeUpdate();
			
			// 반납 완료 메시지 보내기
			String message = vo.getLname() + "(주문번호 " + vo.getOrdid() + ")의 반납이 완료되었습니다.";
			stmt = conn.prepareStatement(RETURN_MESSAGE);
			stmt.setString(1, vo.getCid());
			stmt.setString(2, message);
			stmt.executeUpdate();

			for(DeliveryVO book : bookList) {
				//reserve에서 예약된 도서인지 확인하기
				stmt = conn.prepareStatement(RESERVE_CHECK);
				stmt.setString(1, book.getLid());
				stmt.setLong(2, book.getIsbn());
				rs = stmt.executeQuery();
				if(rs.next()) {
					int count = rs.getInt("count(*)");
					if(count > 0) {
						// 예약된 도서라면 1순위를 0순위로 업데이트
						stmt = conn.prepareStatement(RESERVE_UPDATE);
						stmt.setString(1, book.getLid());
						stmt.setLong(2, book.getIsbn());
						stmt.setLong(3, book.getOrdercnt());
						stmt.executeUpdate();
						
						stmt = conn.prepareStatement(RESERVE_0RANK);
						stmt.setString(1, book.getLid());
						stmt.setLong(2, book.getIsbn());
						rs = stmt.executeQuery();
						while(rs.next()) {
							// 0순위에게 메세지 발송
							message = book.getBookname() + "이(가) 도서관에 도착했습니다.";
							stmt = conn.prepareStatement(RESERVE_MESSAGE);
							stmt.setString(1, rs.getString("cid"));
							stmt.setString(2, message);
							stmt.executeUpdate();
						}
					}
					if(book.getOrdercnt() > count) {					
						// 예약 없을시 or 돌아온 재고가 예약량보다 많을 경우 rental에서 rcnt 돌려놓기
						stmt = conn.prepareStatement(RENTAL_BACK);
						stmt.setLong(1, book.getOrdercnt() - count);
						stmt.setLong(2, book.getIsbn());
						stmt.setString(3, book.getLid());
						stmt.executeUpdate();
					}
				}
			}

			Calendar r = Calendar.getInstance();
			Calendar t = Calendar.getInstance();
			r.setTime(returndate);
			t.setTime(today);

			long latelong = t.getTime().getTime() - r.getTime().getTime();
			int late = (int)latelong/(1000*60*60*24);
			if(returndate.before(today)){
				// late > 0 일 때 연체료 처리
				stmt = conn.prepareStatement(LATE_FEE);
				stmt.setString(1, vo.getCid());
				stmt.setInt(2, late * 100);
				stmt.executeUpdate();
				
				// cpoint에서 실제 차감
				stmt = conn.prepareStatement(MINUS_FEE);
				stmt.setInt(1, late * 100);
				stmt.setString(2, vo.getCid());
				stmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}

	public List<DeliveryVO> lib_getReturnList(DeliveryVO vo) {
		System.out.println("===> JDBC DeliveryDAO2 lib_getReturnList");
		List<DeliveryVO> returnList = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(RETURN_LIST);
			stmt.setString(1, vo.getLid());
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				DeliveryVO ret = new DeliveryVO();
				ret.setOrdid(rs.getLong("ordid"));
				ret.setReturndate(rs.getDate("returndate"));
				ret.setCid(rs.getString("cid"));
				returnList.add(ret);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		
		return returnList;
	}

	public List<DeliveryVO> lib_getReturn_detail(DeliveryVO vo) {
		System.out.println("===> JDBC DeliveryDAO2 lib_getReturn_detail");
		List<DeliveryVO> returnList = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(RETURN_DETAIL);
			stmt.setLong(1, vo.getOrdid());
			stmt.setString(2, vo.getLid());
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				DeliveryVO ret = new DeliveryVO();
				ret.setIsbn(rs.getLong("isbn"));
				ret.setOrdercnt(rs.getLong("ordercnt"));
				ret.setBookname(rs.getString("bookname"));
				returnList.add(ret);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		
		return returnList;
	}

	public List<DeliveryVO> getNewOrder() {
		List<DeliveryVO> newOrder = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(NEW_ORDER);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				DeliveryVO order = new DeliveryVO();
				order.setOrdid(rs.getLong("ordid"));
				order.setCid(rs.getString("cid"));
				order.setOrderdate(rs.getDate("orderdate"));
				order.setOrdmoney(rs.getInt("ordmoney"));
				newOrder.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		
		return newOrder;
	}
}