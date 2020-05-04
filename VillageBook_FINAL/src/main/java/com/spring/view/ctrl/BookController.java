package com.spring.view.ctrl;

import java.beans.PropertyEditorSupport;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.biz.book.BookDAO;
import com.spring.biz.book.BookVO;


@Controller
public class BookController {

   @InitBinder
   public void binder(WebDataBinder binder) {
      binder.registerCustomEditor(java.sql.Date.class, new PropertyEditorSupport() {
         @Override
         public void setAsText(String value) {
            try {
               java.util.Date udt = new SimpleDateFormat("yyyy-MM-dd").parse(value);
               java.sql.Date sdt = new java.sql.Date(udt.getTime());
               setValue(sdt);
               System.out.println(sdt);
            } catch (Exception e) {
               setValue(null);
            }
         }

         @Override
         public String getAsText() {
            return new SimpleDateFormat("yyyy-MM-dd").format((java.sql.Date) getValue());
         }
      });
   }

   @RequestMapping(value = "/lib_newBook.do", method = RequestMethod.GET)
   public String joinView(@ModelAttribute("user") BookVO vo) {
      System.out.println("신권등록 창으로 이동");
      return "lib_newBook.jsp";
   }
   @RequestMapping(value = "/lib_newBook.do", method = RequestMethod.POST)
   public String join(BookVO vo, BookDAO bookDAO, HttpSession session) throws IOException {
      System.out.println("신권등록 처리");
      System.out.println((String) session.getAttribute("lid"));
      
      //Upload FIle
      MultipartFile uploadFile = vo.getUploadFile();
      if(!uploadFile.isEmpty()) {
         String fileName = uploadFile.getOriginalFilename();
         vo.setImg(fileName);
         uploadFile.transferTo(new File("C:/img/book/" + fileName));
      }
      
      vo.setLid((String) session.getAttribute("lid"));
      
      bookDAO.insertBook(vo);
      bookDAO.insertRental(vo);
      
      System.out.println("ISBN: " + vo.getIsbn());
      System.out.println("BOOKNAME: " + vo.getBookname());
      System.out.println("AUTHOR: " + vo.getAuthor());
      System.out.println("PUBLISHER: " + vo.getPublisher());
      System.out.println("PDATE: " + vo.getPdate());
      System.out.println("GENRE: " + vo.getGenre());
      System.out.println("HAVECNT: "+vo.getHavecnt());
      System.out.println("IMG: " + vo.getImg());
      
      return "lib_booklist.do";
   }
   
   @RequestMapping(value = "/lib_modifyBook.do", method = RequestMethod.GET)
   public String modifyView(BookVO vo,BookDAO bookDAO,HttpSession session, Model model) {
      System.out.println("도서정보 수정 창으로 이동");
      model.addAttribute("book", bookDAO.getBook(vo));
      return "lib_modifyBook.jsp";
   }

   @RequestMapping(value = "/lib_modifyBook.do", method = RequestMethod.POST)
   public String updateBook(BookVO vo, BookDAO bookDAO, HttpSession session, Model model) throws IOException {
      System.out.println("도서 정보 수정");
      System.out.println((String) session.getAttribute("lid"));
      vo.setLid((String) session.getAttribute("lid"));
      
      //Upload FIle
      MultipartFile uploadFile = vo.getUploadFile();
      if(!uploadFile.isEmpty()) {
         String fileName = uploadFile.getOriginalFilename();
         vo.setImg(fileName);
         uploadFile.transferTo(new File("C:/img/book/" + fileName));
      }
      
      bookDAO.updateBook(vo);
      bookDAO.updateRental(vo);
      System.out.println("ISBN: " + vo.getIsbn());
      System.out.println("BOOKNAME: " + vo.getBookname());
      System.out.println("AUTHOR: " + vo.getAuthor());
      System.out.println("PUBLISHER: " + vo.getPublisher());
      System.out.println("PDATE: " + vo.getPdate());
      System.out.println("GENRE: " + vo.getGenre());
      System.out.println("HAVECNT: "+vo.getHavecnt());
      System.out.println("IMG: " + vo.getImg());
      return "lib_booklist.do";
   }

   @RequestMapping("/lib_deleteBook.do")
   public String deleteRental(BookVO vo, BookDAO bookDAO, HttpSession session) {
      System.out.println("도서 삭제 처리");
      System.out.println((String) session.getAttribute("lid"));
      System.out.println(vo.getIsbn());
      vo.setLid((String) session.getAttribute("lid"));
      bookDAO.deleteRental(vo);
      bookDAO.deleteBook(vo);
      return "lib_booklist.do";
   }


   @RequestMapping("/getBookList.do")
   public String getBookList(BookVO vo, BookDAO bookDAO, Model model) {
      System.out.println("글 목록 조회 처리");
      if (vo.getSearchCondition() == null)
         vo.setSearchCondition("BOOKNAME");
      if (vo.getSearchKeyword() == null)
         vo.setSearchKeyword("");

      model.addAttribute("bookList", bookDAO.getBookList(vo));
      return "getBookList.jsp";
   }
   @RequestMapping("/getLibBookList.do")
   public String getLibBookList(BookVO vo, BookDAO bookDAO, Model model,HttpSession session) {
      System.out.println("글 목록 조회 처리");
      System.out.println((String) session.getAttribute("lid"));
      vo.setLid((String) session.getAttribute("lid"));
      if (vo.getSearchCondition() == null)
         vo.setSearchCondition("BOOKNAME");
      if (vo.getSearchKeyword() == null)
         vo.setSearchKeyword("");

      model.addAttribute("bookList", bookDAO.getLibBookList(vo));
      return "getLibBookList.jsp";
   }
   @RequestMapping("/lib_booklist.do")
   public String getLibBookList1(BookVO vo, BookDAO bookDAO, Model model,HttpSession session) {
      System.out.println("글 목록 조회 처리1");
      System.out.println((String) session.getAttribute("lid"));
      vo.setLid((String) session.getAttribute("lid"));
      if (vo.getSearchCondition() == null)
         vo.setSearchCondition("BOOKNAME");
      if (vo.getSearchKeyword() == null)
         vo.setSearchKeyword("");

      model.addAttribute("bookList", bookDAO.getLibBookList1(vo));
      return "lib_booklist.jsp";
   }


   @ModelAttribute("conditionMap")
   public Map<String, String> searchCondtionMap() {
      Map<String, String> conditionMap = new HashMap<String, String>();
      conditionMap.put("책제목", "BOOKNAME");
      conditionMap.put("저자", "AUTHOR");
      conditionMap.put("출판사", "PUBLISHER");
      conditionMap.put("카테고리", "GENRE");
      conditionMap.put("ISBN", "ISBN");
      return conditionMap;
   }
}