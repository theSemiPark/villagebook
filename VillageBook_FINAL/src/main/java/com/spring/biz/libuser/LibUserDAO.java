package com.spring.biz.libuser;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.spring.biz.common.JDBCUtil;

public class LibUserDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	
	private final String USER_GET = "select * from library where lid=? and lpw=?";
	private final String USER_INSERT = "insert into library(lid, lpw, lname, ltel, laddr, lholiday, loperate, llogin)"
			+ "values(?, ?, ?, ?, ?, ?, ?, 0)";
	private final String USER_AREAID = "update library set careaid= select id from area where area.gu = (select substr(laddr1,4,3) from user_info where lid=?) where lid=?";
	private final String USER_UPDATE = "update library set lholiday=?, loperate=? where lid=?";

	private final String LOGIN = "update library set llogin = 1 where lid = ?";
	private final String LOGOUT = "update library set llogin = 0 where lid = ?";
	
	public LibUserVO getLibUser(LibUserVO vo) {
		LibUserVO user = null;
		try {
			System.out.println("===> JDBC로 getLibUser() 기능 처리");
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_GET);
			stmt.setString(1, vo.getLid());
			stmt.setString(2, vo.getLpw());
			rs = stmt.executeQuery();
			if (rs.next()) {
				user = new LibUserVO();
				user.setLid(rs.getString("LID"));
				user.setLpw(rs.getString("LPW"));
				user.setLname(rs.getString("LNAME"));
				user.setLtel(rs.getString("LTEL"));
				user.setLaddr(rs.getString("LADDR"));
				user.setLholiday(rs.getString("LHOLIDAY"));
				user.setLoperate(rs.getString("LOPERATE"));
				user.setLlogin(rs.getInt("LLOGIN"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}

		return user;
	}
	public void insertLibUser(LibUserVO vo) {
		System.out.println("===> JDBC로 insertUser() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_INSERT);
			stmt.setString(1, vo.getLid());
			stmt.setString(2, vo.getLpw());
			stmt.setString(3, vo.getLname());
			stmt.setString(4, vo.getLtel());
			stmt.setString(5, vo.getLaddr());
			stmt.setString(6, vo.getLholiday());
			stmt.setString(7, vo.getLoperate());
			// stmt.setString(8, vo.getCid());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public void insertAreaid(LibUserVO vo) {
		System.out.println("===> 사용자 구역 할당");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_AREAID);
			stmt.setString(1, vo.getLid());
			stmt.setString(2, vo.getLid());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}

	}

	//호연 수정
	public void updateLibUser(LibUserVO vo) {
		System.out.println("===> JDBC로 updateBoard() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_UPDATE);
			stmt.setString(1, vo.getLholiday());
			stmt.setString(2, vo.getLoperate());
			stmt.setString(3, vo.getLid());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}

	}
	public void logout(String id) {
		System.out.println("===> JDBC로 logout() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(LOGOUT);
			stmt.setString(1, id);
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}
	
	public void login(String id) {
		System.out.println("===> JDBC로 login() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(LOGIN);
			stmt.setString(1, id);
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}
}
