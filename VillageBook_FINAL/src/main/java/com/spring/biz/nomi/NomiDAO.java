package com.spring.biz.nomi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.biz.common.JDBCUtil;

@Repository ("nomiDAO")
public class NomiDAO {
   private Connection conn = null;
   private PreparedStatement stmt = null;
   private ResultSet rs = null;

   private final String BOARD_INSERT = "insert into nomi(seq, title, writer, content, rating) values((select nvl(max(seq), 0)+1 from nomi), ?,?,?,?)";
   private final String BOARD_UPDATE = "update nomi set title=?, content=?, rating=?  where seq=?";
   private final String BOARD_DELETE = "delete nomi where seq=?";
   private final String HEART_DELETE = "delete nomiheart where seq = ?";
   private final String BOARD_GET = "select a.*, nvl(c, 0) c, nvl(e.d, 0) d from (select * from nomi where seq = ?) a, (select seq, count(seq) c from nomiheart where seq = ? group by seq) b, (select seq, count(seq) d from nomiheart where seq = ? and sender = ? group by seq) e where a.seq = b.seq(+) and a.seq = e.seq(+)";
   private final String BOARD_LIST_T = "select a.*, nvl(c, 0) c from (select * from nomi where title like '%'||?||'%') a, (select seq, count(seq) c from nomiheart group by seq) b where a.seq = b.seq(+) order by a.seq desc";
   private final String BOARD_LIST_C = "select a.*, nvl(c, 0) c from (select * from nomi where content like '%'||?||'%') a, (select seq, count(seq) c from nomiheart group by seq) b where a.seq = b.seq(+) order by a.seq desc";
   private final String BOARD_CNT_UP = "update nomi set cnt=cnt +1 where seq = ?";

   public void insertNomi(NomiVO vo) {
      System.out.println("===> JDBC로 insertNomi() 기능 처리");
      try {
         conn = JDBCUtil.getConnection();
         stmt = conn.prepareStatement(BOARD_INSERT);
         stmt.setString(1, vo.getTitle());
         stmt.setString(2, vo.getWriter());
         stmt.setString(3, vo.getContent());
         stmt.setInt(4, vo.getRating());
         stmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(stmt, conn);
      }
   }

   public int updateNomi(NomiVO vo, int cnt) {
      System.out.println("===> JDBC로 updateNomi() 기능 처리");
      
      Date time = new Date();
      try {
         conn = JDBCUtil.getConnection();
         stmt = conn.prepareStatement(BOARD_UPDATE);
         stmt.setString(1, vo.getTitle());
         stmt.setString(2, vo.getContent()+"\n\n"+time + ")에 수정됨" );
         stmt.setInt(3, vo.getRating());
         stmt.setInt(4, vo.getSeq());
         stmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(stmt, conn);
         cnt++;
         System.out.println(time+" edit done");
      }
      return cnt;
   }
   
   public int updateNomiByAdmin(NomiVO vo, int cnt) {
	      System.out.println("===> JDBC로 admin이 updateNomi() 기능 처리");
	      
	      Date time = new Date();
	      try {
	         conn = JDBCUtil.getConnection();
	         stmt = conn.prepareStatement(BOARD_UPDATE);
	         stmt.setString(1, vo.getTitle());
	         stmt.setString(2, vo.getContent()+"\n\n"+time + ")에 수정됨 by 중앙 관리자" );
	         stmt.setInt(3, vo.getRating());
	         stmt.setInt(4, vo.getSeq());
	         stmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         JDBCUtil.close(stmt, conn);
	         cnt++;
	         System.out.println(time+" edit done");
	      }
	      return cnt;
   }   
   
   public void deleteNomi(NomiVO vo) {
      System.out.println("===> JDBC로 deleteNomi() 기능 처리");
      try {
         conn = JDBCUtil.getConnection();
         stmt = conn.prepareStatement(BOARD_DELETE);
         stmt.setInt(1, vo.getSeq());
         stmt.executeUpdate();
         
         stmt = conn.prepareStatement(HEART_DELETE);
         stmt.setInt(1, vo.getSeq());
         stmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(stmt, conn);
      }
   }

   public void upCnt(NomiVO vo) {
      System.out.println("===> JDBC로 UpNomiCnt() 기능 처리");
      try {
         conn = JDBCUtil.getConnection();
         stmt = conn.prepareStatement(BOARD_CNT_UP);
         stmt.setInt(1, vo.getSeq());
         stmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(stmt, conn);
      }
   }
   
   public NomiVO editNomi(NomiVO vo) {
	      System.out.println("===> JDBC로 editNomi() 이동");
	      NomiVO nomi = null;
	      try {
	         conn = JDBCUtil.getConnection();
	         stmt = conn.prepareStatement(BOARD_GET);
	         stmt.setInt(1, vo.getSeq());
	         stmt.setInt(2, vo.getSeq());
	         stmt.setInt(3, vo.getSeq());
	         stmt.setString(4, "none");
	         rs = stmt.executeQuery();
	         if (rs.next()) {
	            nomi = new NomiVO();
	            nomi.setSeq(rs.getInt("SEQ"));
	            nomi.setTitle(rs.getString("TITLE"));
	            nomi.setWriter(rs.getString("WRITER"));
	            nomi.setContent(rs.getString("CONTENT"));
	            nomi.setRating(rs.getInt("RATING"));
	            nomi.setRegDate(rs.getDate("REGDATE"));
	            nomi.setCnt(rs.getInt("CNT"));
	            nomi.setHowManyHeart(rs.getInt("c"));
	            if(rs.getInt("d") > 0) nomi.setDidIHeart(true);
	            else nomi.setDidIHeart(false);
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         JDBCUtil.close(rs, stmt, conn);
	      }
	      return nomi;
	   }
   
   public NomiVO getNomi(NomiVO vo, String reader) {
      System.out.println("===> JDBC로 getNomi() 기능 처리");
      NomiVO nomi = null;
      try {
         conn = JDBCUtil.getConnection();
         stmt = conn.prepareStatement(BOARD_GET);
         stmt.setInt(1, vo.getSeq());
         stmt.setInt(2, vo.getSeq());
         stmt.setInt(3, vo.getSeq());
         stmt.setString(4, reader);
         rs = stmt.executeQuery();
         if (rs.next()) {
            nomi = new NomiVO();
            nomi.setSeq(rs.getInt("SEQ"));
            nomi.setTitle(rs.getString("TITLE"));
            nomi.setWriter(rs.getString("WRITER"));
            nomi.setContent(rs.getString("CONTENT"));
            nomi.setRating(rs.getInt("RATING"));
            nomi.setRegDate(rs.getDate("REGDATE"));
            nomi.setCnt(rs.getInt("CNT"));
            nomi.setHowManyHeart(rs.getInt("c"));
            if(rs.getInt("d") > 0) nomi.setDidIHeart(true);
            else nomi.setDidIHeart(false);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(rs, stmt, conn);
      }
      return nomi;
   }

   public List<NomiVO> getNomiList(NomiVO vo) {
      System.out.println("===> JDBC로 getNomiList() 기능 처리");
      List<NomiVO> nomiList = new ArrayList<NomiVO>();
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
            NomiVO nomi = new NomiVO();
            nomi = new NomiVO();
            nomi.setSeq(rs.getInt("SEQ"));
            nomi.setTitle(rs.getString("TITLE"));
            nomi.setWriter(rs.getString("WRITER"));
            nomi.setContent(rs.getString("CONTENT"));
            nomi.setRating(rs.getInt("RATING"));
            nomi.setRegDate(rs.getDate("REGDATE"));
            nomi.setCnt(rs.getInt("CNT"));
            nomi.setHowManyHeart(rs.getInt("c"));
            nomiList.add(nomi);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(rs, stmt, conn);
      }
      return nomiList;
   }
}
