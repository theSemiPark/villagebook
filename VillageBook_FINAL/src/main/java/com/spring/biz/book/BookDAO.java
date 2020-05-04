package com.spring.biz.book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.biz.common.JDBCUtil;

@Repository("bookDAO")
public class BookDAO {

   private Connection conn = null;
   private PreparedStatement stmt = null;
   private ResultSet rs = null;

   private final String BOARD_CHECK = "SELECT * FROM BOOK WHERE isbn = ?"; // book 테이블에 동일한 책 있나 체크
   private final String BOARD_INSERT = "insert into book(isbn,bookname,author,publisher,pdate,genre,img)" // 없으면 추가
         + "values(?, ?, ?, ?, ?, ?, ?)";
   private final String BOARD_SAME = "select * from book where isbn=?"; // 있으면 pass

   private final String RENTAL_CHECK = "select * from rental where lid=? and isbn =?"; // rental 테이블에 같은 것 있나 확인
   private final String RENTAL_INSERT = "insert into rental(lid, isbn,rcnt,havecnt) values(?,?,0,1)"; // 없으면 추가
   private final String RENTAL_SAME = "update rental set havecnt = havecnt+1 where lid=? and isbn=?"; // 있으면 havecnt+1
   private final String RENTAL_DELETE = "delete rental where lid=? and isbn=?";
   
   private final String BOARD_UPDATE ="update book set bookname=?,author=?,publisher=?,pdate=?,genre=?, img=? where isbn=? ";
   private final String RENTAL_UPDATE = "update rental set havecnt=? where isbn=?";

   private final String BOARD_CHECK_DELETE ="select * from rental where isbn=? ";
   private final String BOARD_DELETE = "delete book where isbn=?";
   private final String BOARD_GET = "select * from book A ,rental B where A.isbn = B.isbn and B.isbn=?";

   private final String BOARD_LIST_B = "select * from book where bookname like '%'||?||'%' order by isbn desc";
   private final String BOARD_LIST_A = "select * from book where author like '%' || ? || '%' order by isbn desc";
   private final String BOARD_LIST_P = "select * from book where publisher like '%'||?||'%' order by isbn desc";
   private final String BOARD_LIST_G = "select * from book where genre like '%'||?||'%' order by isbn desc";

   private final String LIB_BOARD_LIST_B = "select * from book A ,rental B where A.isbn = B.isbn and B.lid=? and A.bookname like '%'||?||'%' order by A.isbn desc";
   private final String LIB_BOARD_LIST_A = "select * from book A , rental B where A.isbn = B.isbn and B.lid=? and A.author like '%'||?||'%' order by A.isbn desc";
   private final String LIB_BOARD_LIST_P = "select * from book A , rental B where A.isbn = B.isbn and B.lid=? and A.publisher like '%'||?||'%' order by A.isbn desc";
   private final String LIB_BOARD_LIST_G = "select * from book A , rental B where A.isbn = B.isbn and B.lid=? and A.genre like '%'||?||'%' order by A.isbn desc";
   private final String BOARD_LIST_I = "select * from book where isbn like '%'||?||'%' order by isbn desc";

   public void insertBook(BookVO vo) {
      System.out.println("===> JDBC로 insertBook() 기능 처리");

      try {
         conn = JDBCUtil.getConnection();

         stmt = conn.prepareStatement(BOARD_CHECK);
         stmt.setLong(1, vo.getIsbn());
         rs = stmt.executeQuery();

         if (rs.next()) {
            stmt = conn.prepareStatement(BOARD_SAME);
            stmt.setLong(1, rs.getLong("isbn"));
            stmt.executeUpdate();

         } else {
            stmt = conn.prepareStatement(BOARD_INSERT);
            stmt.setLong(1, vo.getIsbn());
            stmt.setString(2, vo.getBookname());
            stmt.setString(3, vo.getAuthor());
            stmt.setString(4, vo.getPublisher());
            stmt.setDate(5, vo.getPdate());
            stmt.setString(6, vo.getGenre());
            stmt.setString(7, vo.getImg());
            stmt.executeUpdate();

         }

      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(stmt, conn);
      }
   }

   public void insertRental(BookVO vo) {
      System.out.println("===> JDBC로 insertRental() 기능 처리");

      try {
         conn = JDBCUtil.getConnection();

         stmt = conn.prepareStatement(RENTAL_CHECK);
         stmt.setString(1, vo.getLid());
         stmt.setLong(2, vo.getIsbn());
         rs = stmt.executeQuery();

         if (rs.next()) {
            stmt = conn.prepareStatement(RENTAL_SAME);
            stmt.setString(1, rs.getString("lid"));
            stmt.setLong(2, rs.getLong("isbn"));
            stmt.executeUpdate();

         } else {
            stmt = conn.prepareStatement(RENTAL_INSERT);
            stmt.setString(1, vo.getLid());
            stmt.setLong(2, vo.getIsbn());
            stmt.executeUpdate();

         }

      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(stmt, conn);
      }
   }

   public void updateBook(BookVO vo) {
      System.out.println("===> JDBC로 updateBook() 기능 처리");
      try {
         conn = JDBCUtil.getConnection();
         stmt = conn.prepareStatement(BOARD_UPDATE);
         stmt.setString(1, vo.getBookname());
         stmt.setString(2, vo.getAuthor());
         stmt.setString(3, vo.getPublisher());
         stmt.setDate(4, vo.getPdate());
         stmt.setString(5, vo.getGenre());
         stmt.setString(6, vo.getImg());
         stmt.setLong(7, vo.getIsbn());
         stmt.executeUpdate();

      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(stmt, conn);
      }
   }
   public void updateRental(BookVO vo) {
      System.out.println("===> JDBC로 updateRental() 기능 처리");
      try {
         conn = JDBCUtil.getConnection();
         stmt = conn.prepareStatement(RENTAL_UPDATE);
         stmt.setLong(1, vo.getHavecnt());
         stmt.setLong(2, vo.getIsbn());
         stmt.executeUpdate();

      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(stmt, conn);
      }
   }

   public void deleteBook(BookVO vo) {
      System.out.println("===> JDBC로 deleteBook() 기능 처리");
      try {
         conn = JDBCUtil.getConnection();
         stmt = conn.prepareStatement(BOARD_CHECK_DELETE);
         stmt.setLong(1, vo.getIsbn());
         rs = stmt.executeQuery();
         if (rs.next()) {
            stmt = conn.prepareStatement(BOARD_GET);
            stmt.setLong(1, vo.getIsbn());
            stmt.executeUpdate();
         } else {
            stmt = conn.prepareStatement(BOARD_DELETE);
            stmt.setLong(1, vo.getIsbn());
            stmt.executeUpdate();

         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(stmt, conn);
      }
   }
   public void deleteRental(BookVO vo) {
      System.out.println("===> JDBC로 deleteRental() 기능 처리");
      try {
         conn = JDBCUtil.getConnection();
         stmt = conn.prepareStatement(RENTAL_DELETE);
         stmt.setString(1, vo.getLid());
         stmt.setLong(2, vo.getIsbn());
         stmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(stmt, conn);
      }
   }

   public BookVO getBook(BookVO vo) {
      System.out.println("===> JDBC로 getBook() 기능 처리");
      BookVO book = null;
      try {
         conn = JDBCUtil.getConnection();
         stmt = conn.prepareStatement(BOARD_GET);
         stmt.setLong(1, vo.getIsbn());
         rs = stmt.executeQuery();
         if (rs.next()) {
            book = new BookVO();
            book.setLid(rs.getString("LID"));
            book.setRcnt(rs.getInt("RCNT"));
            book.setHavecnt(rs.getInt("HAVECNT"));
            book.setIsbn(rs.getLong("ISBN"));
            book.setBookname(rs.getString("BOOKNAME"));
            book.setAuthor(rs.getString("AUTHOR"));
            book.setPublisher(rs.getString("PUBLISHER"));
            book.setPdate(rs.getDate("PDATE"));
            book.setGenre(rs.getString("GENRE"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(rs, stmt, conn);
      }
      return book;
   }

   public List<BookVO> getBookList(BookVO vo) {
         System.out.println("===>JDBC로 getBookList() 기능 처리");
         List<BookVO> bookList = new ArrayList<BookVO>();
         try {
            conn = JDBCUtil.getConnection();
            if (vo.getSearchCondition().equals("BOOKNAME")) {
               stmt = conn.prepareStatement(BOARD_LIST_B);
            } else if (vo.getSearchCondition().equals("AUTHOR")) {
               stmt = conn.prepareStatement(BOARD_LIST_A);
            } else if (vo.getSearchCondition().equals("PUBLISHER")) {
               stmt = conn.prepareStatement(BOARD_LIST_P);
            } else if (vo.getSearchCondition().equals("GENRE")) {
               stmt = conn.prepareStatement(BOARD_LIST_G);
            } else if (vo.getSearchCondition().equals("ISBN")) {
               stmt = conn.prepareStatement(BOARD_LIST_I);
            } 
            stmt.setString(1, vo.getSearchKeyword());
            rs = stmt.executeQuery();
            while (rs.next()) {
               BookVO book = new BookVO();
               book.setIsbn(rs.getLong("ISBN"));
               book.setBookname(rs.getString("BOOKNAME"));
               book.setAuthor(rs.getString("AUTHOR"));
               book.setPublisher(rs.getString("PUBLISHER"));
               book.setPdate(rs.getDate("PDATE"));
               book.setGenre(rs.getString("GENRE"));
               bookList.add(book);
            }
         } catch (Exception e) {
            e.printStackTrace();
         } finally {
            JDBCUtil.close(rs, stmt, conn);
         }
         return bookList;
      }

   public List<BookVO> getLibBookList(BookVO vo) { // modify, delete를 위한 리스트
      System.out.println("===>JDBC로 getLibBookList() 기능 처리");
      List<BookVO> bookList = new ArrayList<BookVO>();
      try {
         conn = JDBCUtil.getConnection();
         if (vo.getSearchCondition().equals("BOOKNAME")) {
            stmt = conn.prepareStatement(LIB_BOARD_LIST_B);
         } else if (vo.getSearchCondition().equals("AUTHOR")) {
            stmt = conn.prepareStatement(LIB_BOARD_LIST_A);
         } else if (vo.getSearchCondition().equals("PUBLISHER")) {
            stmt = conn.prepareStatement(LIB_BOARD_LIST_P);
         } else if (vo.getSearchCondition().equals("GENRE")) {
            stmt = conn.prepareStatement(LIB_BOARD_LIST_G);
         }
         stmt.setString(1, vo.getLid());
         stmt.setString(2, vo.getSearchKeyword());
         rs = stmt.executeQuery();

         while (rs.next()) {
            BookVO book = new BookVO();
            book.setIsbn(rs.getLong("ISBN"));
            book.setBookname(rs.getString("BOOKNAME"));
            book.setAuthor(rs.getString("AUTHOR"));
            book.setPublisher(rs.getString("PUBLISHER"));
            book.setPdate(rs.getDate("PDATE"));
            book.setGenre(rs.getString("GENRE"));
            bookList.add(book);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(rs, stmt, conn);
      }
      return bookList;
   }

   public List<BookVO> getLibBookList1(BookVO vo) { // lib_booklist.jsp
      System.out.println("===>JDBC로 getLibBookList1() 기능 처리");
      List<BookVO> bookList = new ArrayList<BookVO>();
      try {
         conn = JDBCUtil.getConnection();
         if (vo.getSearchCondition().equals("BOOKNAME")) {
            stmt = conn.prepareStatement(LIB_BOARD_LIST_B);
         } else if (vo.getSearchCondition().equals("AUTHOR")) {
            stmt = conn.prepareStatement(LIB_BOARD_LIST_A);
         } else if (vo.getSearchCondition().equals("PUBLISHER")) {
            stmt = conn.prepareStatement(LIB_BOARD_LIST_P);
         } else if (vo.getSearchCondition().equals("GENRE")) {
            stmt = conn.prepareStatement(LIB_BOARD_LIST_G);
         }
         stmt.setString(1, vo.getLid());
         stmt.setString(2, vo.getSearchKeyword());
         rs = stmt.executeQuery();

         while (rs.next()) {
            BookVO book = new BookVO();
            book.setIsbn(rs.getLong("ISBN"));
            book.setBookname(rs.getString("BOOKNAME"));
            book.setAuthor(rs.getString("AUTHOR"));
            book.setPublisher(rs.getString("PUBLISHER"));
            book.setPdate(rs.getDate("PDATE"));
            book.setGenre(rs.getString("GENRE"));
            book.setHavecnt(rs.getInt("HAVECNT"));
            bookList.add(book);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         JDBCUtil.close(rs, stmt, conn);
      }
      return bookList;
   }

}