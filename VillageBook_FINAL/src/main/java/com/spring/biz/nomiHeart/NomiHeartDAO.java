package com.spring.biz.nomiHeart;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.springframework.stereotype.Repository;

import com.spring.biz.common.JDBCUtil;

@Repository("nomiHeartDAO")
public class NomiHeartDAO {

	private Connection conn = null;
	private PreparedStatement stmt = null;

	private final String INSERT_NHEART = "INSERT INTO NOMIHEART VALUES (NHEART_SEQ.NEXTVAL, ?, ?)";
	private final String DELETE_NHEART = "DELETE FROM NOMIHEART WHERE SEQ = ? AND SENDER = ?";
	
	public void insertNomiHeart(NomiHeartVO vo) {
		System.out.println("===> JDBC로 insertNomiHeart() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(INSERT_NHEART);
			stmt.setLong(1, vo.getSeq());
			stmt.setString(2, vo.getSender());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public void deleteNomiHeart(NomiHeartVO vo) {
		System.out.println("===> JDBC로 deleteNomiHeart() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(DELETE_NHEART);
			stmt.setLong(1, vo.getSeq());
			stmt.setString(2, vo.getSender());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}
}
