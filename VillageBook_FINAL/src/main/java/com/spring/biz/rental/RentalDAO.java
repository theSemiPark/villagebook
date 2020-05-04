package com.spring.biz.rental;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.spring.biz.common.JDBCUtil;

public class RentalDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;

	// 대여관리 페이지용
	private final String RENTAL_GET = "select lid, book.bookname, rental.isbn, rcnt, havecnt "
			+ "from book, rental where lid = ? and book.isbn = rental.isbn";
	private final String RENTAL_STATUS = "select rental.lid, delivery.orderdate, rental.isbn, delivery.bookname, user_info.cname, "
			+ "delivery.cid from delivery, rental, user_info \r\n"
			+ "where rental.lid = ? and rental.isbn = ? and rental.isbn = delivery.isbn and user_info.cid = delivery.cid and returnwer != 'Y'";
	private final String GET_BEST_BOOK = "SELECT LID, BOOKNAME, ISBN, COUNT(ORDERCNT) FROM DELIVERY WHERE LID = ? GROUP BY ISBN, BOOKNAME, LID ORDER BY COUNT(ORDERCNT)";

	public List<RentalVO> getRentalList(RentalVO vo) {
		System.out.println("===>JDBC로 getRentalList() 기능처리");
		List<RentalVO> rentalList = new ArrayList<RentalVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(RENTAL_GET);
			System.out.println(vo.getLid());
			stmt.setString(1, vo.getLid());
			rs = stmt.executeQuery();
			while (rs.next()) {
				RentalVO rental = new RentalVO();
				rental.setLid(rs.getString("LID"));
				rental.setBookname(rs.getString("BOOKNAME"));
				rental.setIsbn(rs.getLong("ISBN"));
				rental.setRcnt(rs.getInt("RCNT"));
				rental.setHavecnt(rs.getInt("HAVECNT"));
				rentalList.add(rental);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return rentalList;
	}

	public List<RentalVO> getRentalStatus(RentalVO vo2) {
		System.out.println("==> 대여현황, 대여 회원 조회");
		List<RentalVO> rentalStatus = new ArrayList<RentalVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(RENTAL_STATUS);
			System.out.println(vo2.getLid());
			stmt.setString(1, vo2.getLid());
			stmt.setLong(2, vo2.getIsbn());
			rs = stmt.executeQuery();
			while (rs.next()) {
				RentalVO status = new RentalVO();
				status = new RentalVO();
				status.setLid(rs.getString("lid"));
				status.setOrderdate(rs.getDate("orderdate"));
				status.setIsbn(rs.getLong("isbn"));
				status.setBookname(rs.getString("bookname"));
				status.setCname(rs.getString("cname"));
				status.setCid(rs.getString("cid"));
				rentalStatus.add(status);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return rentalStatus;
	}

	// 대여수 높은 책 get
	public List<RentalVO> getBestBook(RentalVO vo) {
		System.out.println("===> 주문 순위 확인");
		List<RentalVO> bestBook = new ArrayList<RentalVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(GET_BEST_BOOK);
			System.out.println(vo.getLid());
			stmt.setString(1, vo.getLid());
			rs = stmt.executeQuery();
			while (rs.next()) {
				RentalVO best = new RentalVO();
				best.setLid(rs.getString("lid"));
				best.setBookname(rs.getString("bookname"));
				best.setIsbn(rs.getLong("isbn"));
				best.setOrdercnt(rs.getInt("count(ordercnt)"));
				bestBook.add(best);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return bestBook;
	}

}
