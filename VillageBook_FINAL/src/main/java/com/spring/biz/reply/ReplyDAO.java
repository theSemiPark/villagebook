package com.spring.biz.reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.spring.biz.common.JDBCUtil;
import com.spring.biz.notice.NoticeVO;
import com.spring.biz.qna.QnAVO;

public class ReplyDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	
	private final String INSERT_QREPLY = "INSERT INTO QNA_REPLY VALUES (qreplyid_seq.nextval, ?, ?, sysdate, ?)";
	private final String INSERT_NREPLY = "INSERT INTO NOTICE_REPLY VALUES (nreplyid_seq.nextval, ?, ?, sysdate, ?)";
	private final String UPDATE_REPLYCNT = "UPDATE QNA SET REPLYCNT = REPLYCNT + 1 WHERE SEQ = ?";
	private final String UPDATE_REPLYCNT_MINUS = "UPDATE QNA SET REPLYCNT = REPLYCNT - 1 WHERE SEQ = ?";
	private final String REPLY_GET = "select * from qna_reply where seq = ? order by qreplyid";
	private final String REPLY_GET_NOTICE = "select * from notice_reply where seq = ? order by nreplyid";
	private final String DELETE_QREPLY = "DELETE FROM QNA_REPLY WHERE QREPLYID = ?";
	private final String DELETE_NREPLY = "DELETE FROM NOTICE_REPLY WHERE NREPLYID = ?";
	private final String UPDATE_REPLYCNT_NOTICE = "UPDATE NOTICE SET REPLYCNT = REPLYCNT + 1 WHERE SEQ = ?";
	private final String UPDATE_REPLYCNT_MINUS_NOTICE = "UPDATE NOTICE SET REPLYCNT = REPLYCNT - 1 WHERE SEQ = ?";

	
	public void insertReply(ReplyVO vo) {
		System.out.println("===> JDBC로  insertReply() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(INSERT_QREPLY);
			stmt.setLong(1, vo.getSeq());
			stmt.setString(2, vo.getWriter());
			stmt.setString(3, vo.getRcontent());
			stmt.executeUpdate();
			
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(UPDATE_REPLYCNT);
			stmt.setLong(1, vo.getSeq());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}
	
	public List<ReplyVO> getReply(QnAVO vo) {
		System.out.println("===> JDBC로 getQnAList() 기능 처리");
		List<ReplyVO> replyList = new ArrayList<ReplyVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(REPLY_GET);
			stmt.setLong(1, vo.getSeq());
			rs = stmt.executeQuery();
			while (rs.next()) {
				ReplyVO reply = new ReplyVO();
				reply.setSeq(rs.getLong("seq"));
				reply.setQreplyid(rs.getLong("qreplyid"));
				reply.setWriter(rs.getString("writer"));
				reply.setRegdate(rs.getDate("regdate"));
				reply.setRcontent(rs.getString("rcontent"));
				replyList.add(reply);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return replyList;
	}

	public void deleteReply(ReplyVO vo) {
		System.out.println("===> JDBC로  deleteReply() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(DELETE_QREPLY);
			stmt.setLong(1, vo.getQreplyid());
			stmt.executeUpdate();
			
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(UPDATE_REPLYCNT_MINUS);
			stmt.setLong(1, vo.getSeq());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public List<ReplyVO> getReply_notice(NoticeVO vo) {
		System.out.println("===> JDBC로getReply_notice() 기능 처리");
		List<ReplyVO> replyList = new ArrayList<ReplyVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(REPLY_GET_NOTICE);
			stmt.setLong(1, vo.getSeq());
			rs = stmt.executeQuery();
			while (rs.next()) {
				ReplyVO reply = new ReplyVO();
				reply.setSeq(rs.getLong("seq"));
				reply.setQreplyid(rs.getLong("nreplyid"));
				reply.setWriter(rs.getString("writer"));
				reply.setRegdate(rs.getDate("regdate"));
				reply.setRcontent(rs.getString("rcontent"));
				replyList.add(reply);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return replyList;
	}

	public void insertReply_notice(ReplyVO vo) {
		System.out.println("===> JDBC로  insertReply_notice() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(INSERT_NREPLY);
			stmt.setLong(1, vo.getSeq());
			stmt.setString(2, vo.getWriter());
			stmt.setString(3, vo.getRcontent());
			stmt.executeUpdate();
			
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(UPDATE_REPLYCNT_NOTICE);
			stmt.setLong(1, vo.getSeq());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public void deleteReply_notice(ReplyVO vo) {
		System.out.println("===> JDBC로  deleteReply_notice() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(DELETE_NREPLY);
			stmt.setLong(1, vo.getQreplyid());
			stmt.executeUpdate();
			
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(UPDATE_REPLYCNT_MINUS_NOTICE);
			stmt.setLong(1, vo.getSeq());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}
}
