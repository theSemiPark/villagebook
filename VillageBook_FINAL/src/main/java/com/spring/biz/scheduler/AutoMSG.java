package com.spring.biz.scheduler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.biz.common.JDBCUtil;

@Component
public class AutoMSG {

	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	private ResultSet rs2 = null;
	private ResultSet rs3 = null;

	private final String BEFOREDAY = "SELECT distinct cid from delivery where trunc(returndate) <= trunc(sysdate+1) and trunc(returndate) > trunc(sysdate) and returnwer='N'";
	private final String THATDAY = "SELECT distinct cid from delivery where trunc(returndate) = trunc(sysdate) and returnwer='N'";
	private final String AFTERDAY = "SELECT distinct cid from delivery where trunc(returndate) < trunc(sysdate) and returnwer='N'";
	private final String INSERT_MSG = "INSERT INTO MESSAGE VALUES (M_SEQ.NEXTVAL, ?, 'server', ?, NULL, SYSDATE)";
	private final String SELECT_0RANK = "select lid, isbn, count(*) from reserve where revrank = 0 group by lid, isbn";
	private final String DELETE_0RANK = "DELETE FROM RESERVE WHERE REVRANK = 0";
	private final String SELECT_NEW_0RANK = "select cid from reserve where isbn = ? and lid = ? and revrank = 2";
	private final String SELECT_BOOKNAME = "select bookname from book where isbn = ?";
	private final String UPDATE_RANK = "UPDATE RESERVE SET REVRANK = 0 WHERE ISBN = ? AND LID = ?";
	private final String INSERT_REV_MSG = "insert into message values (m_seq.nextval, ?, 'server', ?, null, sysdate)";
	private final String RENTAL_BACK = "UPDATE RENTAL SET RCNT = RCNT - ? WHERE ISBN = ? AND LID = ?";

	private final String CART_BOMB_AUTO = "delete from cart where sysdate-indate > 7";

	@Scheduled(cron = "0 0 09 * * *")
	public void autoMessage() {
		System.out.println("===> JDBC로 autoMessage() 기능처리");
		String message = "";
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(BEFOREDAY);
			rs = stmt.executeQuery();
			message = "반납일이 임박했습니다.";
			while (rs.next()) {
				stmt = conn.prepareStatement(INSERT_MSG);
				stmt.setString(1, rs.getString("cid"));
				stmt.setString(2, message);
				stmt.executeUpdate();
			}

			stmt = conn.prepareStatement(THATDAY);
			rs = stmt.executeQuery();
			message = "반납일입니다. 도서관 운영시간 내에 반납을 완료해주세요.";
			while (rs.next()) {
				stmt = conn.prepareStatement(INSERT_MSG);
				stmt.setString(1, rs.getString("cid"));
				stmt.setString(2, message);
				stmt.executeUpdate();
			}

			stmt = conn.prepareStatement(AFTERDAY);
			rs = stmt.executeQuery();
			message = "반납일이 지났습니다. 연체료는 하루에 100원입니다.";
			while (rs.next()) {
				stmt = conn.prepareStatement(INSERT_MSG);
				stmt.setString(1, rs.getString("cid"));
				stmt.setString(2, message);
				stmt.executeUpdate();
			}

			// revrank = 0 인 애들 가져와서 rs에 저장
			stmt = conn.prepareStatement(SELECT_0RANK);
			rs = stmt.executeQuery();
			// 걔들은 삭제
			stmt = conn.prepareStatement(DELETE_0RANK);
			stmt.executeUpdate();
			while (rs.next()) {
				int count = rs.getInt("count(*)");
				stmt = conn.prepareStatement(SELECT_NEW_0RANK);
				stmt.setLong(1, rs.getLong("isbn"));
				stmt.setString(2, rs.getString("lid"));
				rs2 = stmt.executeQuery();
				if (rs2.next()) {
					count--;
					// 0순위가 터진 경우 2순위가 0순위로 업데이트
					stmt = conn.prepareStatement(UPDATE_RANK);
					stmt.setLong(1, rs.getLong("isbn"));
					stmt.setString(2, rs.getString("lid"));
					stmt.executeUpdate();

					// 새로운 0순위를 위한 알림
					stmt = conn.prepareStatement(SELECT_BOOKNAME);
					stmt.setLong(1, rs.getLong("isbn"));
					rs3 = stmt.executeQuery();
					if (rs3.next()) {
						message = rs3.getString("bookname") + "이(가) 도서관에 도착했습니다.";
						stmt = conn.prepareStatement(INSERT_REV_MSG);
						stmt.setString(1, rs2.getString("cid"));
						stmt.setString(2, message);
						stmt.executeUpdate();
					}
				}
				stmt = conn.prepareStatement(RENTAL_BACK);
				stmt.setInt(1, count);
				stmt.setLong(2, rs.getLong("isbn"));
				stmt.setString(3, rs.getString("lid"));
				stmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}

	@Scheduled(cron = "0 0 09 * * *")
	public void bombCart() {
		System.out.println("===> JDBC로 bombCartAuto() 기능처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(CART_BOMB_AUTO);
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}
}
