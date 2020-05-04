package com.spring.biz.reserve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.biz.common.JDBCUtil;

@Repository("reserveDAO")
public class ReserveDAO {

	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	
	private final String RESERVE_ALREADY = "select * from reserve where cid = ? and isbn = ? and lid = ?";
	private final String SEARCH_RESERVE = "select max(revrank) from reserve where isbn = ? and lid = ?";
	private final String INSERT_RESERVE = "insert into reserve values(rev_id.nextval, ?, ?, ?, ? + 1)";
	private final String SELECT_RESERVE_LIB = "select reserve.*, book.bookname from reserve, book where lid = ? and reserve.isbn = book.isbn order by reserve.isbn desc, revrank asc";
	private final String SELECT_RESERVE = "select reserve.*, book.bookname, library.lname from reserve, book, library where cid = ? and reserve.isbn = book.isbn and library.lid = reserve.lid order by reserve.isbn desc, revrank asc";
	private final String DELETE_RESERVE = "delete from reserve where revid = ?";
	private final String DELETE_UPDATE = "update reserve set revrank = revrank - 1 where lid = ? and isbn = ? and revrank > ?";
	
	public char insertReserve(ReserveVO vo) {
		System.out.println("===> JDBC로 insertReserve() 기능처리");
		char result = '0';
		try {
			conn = JDBCUtil.getConnection();

			stmt = conn.prepareStatement(RESERVE_ALREADY);
			stmt.setString(1, vo.getCid());
			stmt.setLong(2, vo.getIsbn());
			stmt.setString(3, vo.getLid());
			rs = stmt.executeQuery();

			if (rs.next())
				result = '1'; // 이미 예약함
			else {
				stmt = conn.prepareStatement(SEARCH_RESERVE);
				stmt.setLong(1, vo.getIsbn());
				stmt.setString(2, vo.getLid());
				rs = stmt.executeQuery();

				if (rs.next()) {
					int max = rs.getInt("max(revrank)");
					if (max >= 2) { // 예약 가능 인원 초과
						result = '0';
					} else {
						stmt = conn.prepareStatement(INSERT_RESERVE);
						stmt.setString(1, vo.getCid());
						stmt.setLong(2, vo.getIsbn());
						stmt.setString(3, vo.getLid());
						stmt.setInt(4, max);
						stmt.executeUpdate();
						result = '2';
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
		return result;
	}

	public List<ReserveVO> getReserveList_lib(ReserveVO vo) {
		System.out.println("===> JDBC로 getReserveList_lib() 기능처리");
		List<ReserveVO> reserveList = new ArrayList<ReserveVO>();
		try {
			conn = JDBCUtil.getConnection();

			stmt = conn.prepareStatement(SELECT_RESERVE_LIB);
			stmt.setString(1, vo.getLid());
			rs = stmt.executeQuery();

			while (rs.next()) {
				ReserveVO reserve = new ReserveVO();
				reserve.setCid(rs.getString("cid"));
				reserve.setIsbn(rs.getLong("isbn"));
				reserve.setBookname(rs.getString("bookname"));
				reserve.setRevrank(rs.getInt("revrank"));
				reserve.setRevid(rs.getLong("revid"));
				reserveList.add(reserve);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
		return reserveList;
	}

	public void deleteReserve(ReserveVO vo) {
		System.out.println("===> JDBC로 deleteReserve() 기능처리");
		try {
			conn = JDBCUtil.getConnection();

			stmt = conn.prepareStatement(DELETE_RESERVE);
			stmt.setLong(1, vo.getRevid());
			stmt.executeUpdate();
			
			stmt = conn.prepareStatement(DELETE_UPDATE);
			System.out.println(vo.getLid() + ":" + vo.getIsbn() + ":" + vo.getRevrank());
			stmt.setString(1, vo.getLid());
			stmt.setLong(2, vo.getIsbn());
			stmt.setInt(3, vo.getRevrank());
			stmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public List<ReserveVO> getReserveList(ReserveVO vo) {
		System.out.println("===> JDBC로 getReserveList() 기능처리");
		List<ReserveVO> reserveList = new ArrayList<ReserveVO>();
		try {
			conn = JDBCUtil.getConnection();

			stmt = conn.prepareStatement(SELECT_RESERVE);
			stmt.setString(1, vo.getCid());
			rs = stmt.executeQuery();

			while (rs.next()) {
				ReserveVO reserve = new ReserveVO();
				reserve.setLid(rs.getString("lid"));
				reserve.setLname(rs.getString("lname"));
				reserve.setIsbn(rs.getLong("isbn"));
				reserve.setBookname(rs.getString("bookname"));
				reserve.setRevrank(rs.getInt("revrank"));
				reserve.setRevid(rs.getLong("revid"));
				reserveList.add(reserve);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
		return reserveList;
	}
}