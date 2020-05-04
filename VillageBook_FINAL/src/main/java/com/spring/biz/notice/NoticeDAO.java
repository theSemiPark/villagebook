package com.spring.biz.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.biz.common.JDBCUtil;
import com.spring.biz.notice.NoticeVO;

@Repository ("noticeDAO")
public class NoticeDAO {
   private Connection conn = null;
   private PreparedStatement stmt = null;
   private ResultSet rs = null;

   private final String BOARD_INSERT = "insert into notice(seq, title, writer, content) values((select nvl(max(seq), 0)+1 from notice), ?,? ,?)";
   private final String BOARD_DELETE = "delete notice where seq=?";
   private final String BOARD_GET = "select * from notice where seq = ?";
   private final String BOARD_LIST_T = "select * from notice where title like '%'||?||'%' order by seq desc";
   private final String BOARD_LIST_C = "select * from notice where content like '%'||?||'%' order by seq desc";
   private final String BOARD_CNT_UP = "update notice set cnt=cnt +1 where seq = ?";
   private final String REPLY_DELETE = "delete notice_reply where seq = ?";

   public void insertNotice(NoticeVO vo) {
      System.out.println("===> JDBC로  insertNotice() 기능 처리");
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
	   
   public void deleteNotice(NoticeVO vo) {
      System.out.println("===> JDBC로 deleteNotice() 기능 처리");
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

   public void upCnt(NoticeVO vo) {
      System.out.println("===> JDBC로 UpNoticeCnt() 기능 처리");
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
   
   
   public NoticeVO getNotice(NoticeVO vo) {
      System.out.println("===> JDBC로 getNotice() 기능 처리");
      NoticeVO notice = null;
      try {
         conn = JDBCUtil.getConnection();
         stmt = conn.prepareStatement(BOARD_GET);
         stmt.setLong(1, vo.getSeq());
         rs = stmt.executeQuery();
         if (rs.next()) {
            notice = new NoticeVO();
            notice.setSeq(rs.getLong("SEQ"));
            notice.setTitle(rs.getString("TITLE"));
            notice.setWriter(rs.getString("WRITER"));
            notice.setContent(rs.getString("CONTENT"));
            notice.setRegDate(rs.getDate("REGDATE"));
            notice.setCnt(rs.getInt("CNT"));
            notice.setReplycnt(rs.getInt("REPLYCNT"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(rs, stmt, conn);
      }
      return notice;
   }

   public List<NoticeVO> getNoticeList(NoticeVO vo) {
      System.out.println("===> JDBC로 getNoticeList() 기능 처리");
      List<NoticeVO> noticeList = new ArrayList<NoticeVO>();
      try {
         conn = JDBCUtil.getConnection();
         if(vo.getSearchCondition().equals("TITLE")) {
            stmt = conn.prepareStatement(BOARD_LIST_T);
         }else if(vo.getSearchCondition().equals("CONTENT")) {
            stmt = conn.prepareStatement(BOARD_LIST_C);
         }
         stmt.setString(1, vo.getSearchKeyword());
         rs = stmt.executeQuery();
         while (rs.next()) {
            NoticeVO notice = new NoticeVO();
            notice = new NoticeVO();
            notice.setSeq(rs.getLong("SEQ"));
            notice.setTitle(rs.getString("TITLE"));
            notice.setWriter(rs.getString("WRITER"));
            notice.setContent(rs.getString("CONTENT"));
            notice.setRegDate(rs.getDate("REGDATE"));
            notice.setCnt(rs.getInt("CNT"));
            notice.setReplycnt(rs.getInt("REPLYCNT"));
            noticeList.add(notice);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(rs, stmt, conn);
      }
      return noticeList;
   }
}
