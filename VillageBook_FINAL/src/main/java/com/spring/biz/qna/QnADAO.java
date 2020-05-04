package com.spring.biz.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.biz.common.JDBCUtil;
import com.spring.biz.reply.ReplyVO;

@Repository("qnaDAO")
public class QnADAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;

	private final String BOARD_INSERT = "insert into qna(seq, title, writer, content) values((select nvl(max(seq), 0)+1 from qna), ?,? ,?)";
	private final String BOARD_DELETE = "delete qna where seq=?";
	private final String REPLY_DELETE = "delete qna_reply where seq = ?";
	private final String BOARD_GET = "select * from qna where seq = ?";
	private final String BOARD_LIST_T = "select * from qna where title like '%'||?||'%' and writer = ? order by seq desc";
	private final String BOARD_LIST_C = "select * from qna where content like '%'||?||'%' and writer = ? order by seq desc";
	private final String BOARD_LIST_T2 = "select * from qna where title like '%'||?||'%' order by seq desc";
	private final String BOARD_LIST_C2 = "select * from qna where content like '%'||?||'%' order by seq desc";
	private final String BOARD_CNT_UP = "update qna set cnt=cnt +1 where seq = ?";
	private final String UPDATE_REPLYTF = "update qna set replytf = 'O' where seq = ?";

	public void insertQnA(QnAVO vo) {
		System.out.println("===> JDBC로  insertQnA() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(BOARD_INSERT);
			stmt.setString(1, vo.getTitle());
			stmt.setString(2, vo.getWriter());
			stmt.setString(3, vo.getContent());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public void deleteQnA(QnAVO vo) {
		System.out.println("===> JDBC로 deleteQnA() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(BOARD_DELETE);
			stmt.setLong(1, vo.getSeq());
			stmt.executeUpdate();
			
			stmt = conn.prepareStatement(REPLY_DELETE);
			stmt.setLong(1, vo.getSeq());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public void upCnt(QnAVO vo) {
		System.out.println("===> JDBC로 UpQnACnt() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(BOARD_CNT_UP);
			stmt.setLong(1, vo.getSeq());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public QnAVO getQnA(QnAVO vo) {
		System.out.println("===> JDBC로 getQnA() 기능 처리");
		QnAVO qna = null;
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(BOARD_GET);
			stmt.setLong(1, vo.getSeq());
			rs = stmt.executeQuery();
			if (rs.next()) {
				qna = new QnAVO();
				qna.setSeq(rs.getLong("SEQ"));
				qna.setTitle(rs.getString("TITLE"));
				qna.setWriter(rs.getString("WRITER"));
				qna.setContent(rs.getString("CONTENT"));
				qna.setRegDate(rs.getDate("REGDATE"));
				qna.setCnt(rs.getInt("CNT"));
				qna.setReplycnt(rs.getInt("replycnt"));
				qna.setReplytf(rs.getString("replytf"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return qna;
	}

	public List<QnAVO> getQnAList(QnAVO vo) {
		System.out.println("===> JDBC로 getQnAList() 기능 처리");
		List<QnAVO> qnaList = new ArrayList<QnAVO>();
		try {
			conn = JDBCUtil.getConnection();
			if (vo.getSearchCondition().equals("TITLE")) {
				stmt = conn.prepareStatement(BOARD_LIST_T);
			} else if (vo.getSearchCondition().equals("CONTENT")) {
				stmt = conn.prepareStatement(BOARD_LIST_C);
			}
			stmt.setString(1, vo.getSearchKeyword());
			stmt.setString(2, vo.getWriter());
			rs = stmt.executeQuery();
			while (rs.next()) {
				QnAVO qna = new QnAVO();
				qna.setSeq(rs.getLong("SEQ"));
				qna.setTitle(rs.getString("TITLE"));
				qna.setWriter(rs.getString("WRITER"));
				qna.setContent(rs.getString("CONTENT"));
				qna.setRegDate(rs.getDate("REGDATE"));
				qna.setCnt(rs.getInt("CNT"));
				qna.setReplycnt(rs.getInt("replycnt"));
				qna.setReplytf(rs.getString("replytf"));
				qnaList.add(qna);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return qnaList;
	}
	
	public List<QnAVO> getQnAList_biz(QnAVO vo) {
		System.out.println("===> JDBC로 getQnAList() by biz 기능 처리");
		List<QnAVO> qnaList = new ArrayList<QnAVO>();
		try {
			conn = JDBCUtil.getConnection();
			if (vo.getSearchCondition().equals("TITLE")) {
				stmt = conn.prepareStatement(BOARD_LIST_T2);
			} else if (vo.getSearchCondition().equals("CONTENT")) {
				stmt = conn.prepareStatement(BOARD_LIST_C2);
			}
			stmt.setString(1, vo.getSearchKeyword());
			rs = stmt.executeQuery();
			while (rs.next()) {
				QnAVO qna = new QnAVO();
				qna.setSeq(rs.getLong("SEQ"));
				qna.setTitle(rs.getString("TITLE"));
				qna.setWriter(rs.getString("WRITER"));
				qna.setContent(rs.getString("CONTENT"));
				qna.setRegDate(rs.getDate("REGDATE"));
				qna.setCnt(rs.getInt("CNT"));
				qna.setReplycnt(rs.getInt("replycnt"));
				qna.setReplytf(rs.getString("replytf"));
				qnaList.add(qna);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return qnaList;
	}	
	
	public void updateReplyTF(ReplyVO vo) {
		System.out.println("===> JDBC로 updateReplyTF() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(UPDATE_REPLYTF);
			stmt.setLong(1, vo.getSeq());
			stmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}
}
