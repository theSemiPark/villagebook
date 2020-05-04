package com.spring.view.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.biz.qna.QnADAO;
import com.spring.biz.qna.QnAVO;
import com.spring.biz.reply.ReplyDAO;

@Controller
public class QnAController {

   @RequestMapping("/insertQnA.do")
   public String insertQnA(QnAVO vo, QnADAO qnaDAO, String horsehead) {
      System.out.println("글 등록 처리");
      if (horsehead != "") vo.setTitle("[" + horsehead + "] " + vo.getTitle());
      qnaDAO.insertQnA(vo);
      return "getQnAList.do";      
   }
   
   @RequestMapping("/deleteQnA.do")
   public String deleteQnA(QnAVO vo, QnADAO qnaDAO, HttpSession session) {
      System.out.println("글 삭제 처리");
      qnaDAO.deleteQnA(vo);
      
      String cid = (String)session.getAttribute("cid");
      if (cid != null) return "getQnAList.do";
      String lid = (String)session.getAttribute("lid");
      if (lid.equals("admin")) return "admin_QnAList.do";
      else return "lib_QnAList.do";
   }
   
   @RequestMapping("/getQnA.do")
   public String getQnA(ReplyDAO replyDAO, QnAVO vo, QnADAO qnaDAO, Model model) {
      System.out.println("글 상세 조회 처리");
      qnaDAO.upCnt(vo);
      model.addAttribute("qna", qnaDAO.getQnA(vo));
      model.addAttribute("replyList", replyDAO.getReply(vo));

      return "getQnA.jsp";
   }
   
   @RequestMapping("/getQnAList.do")
   public String getQnAList(QnAVO vo, QnADAO qnaDAO, Model model,HttpSession session) {
      System.out.println("글 목록 조회 처리");
      
      if(vo.getSearchCondition() == null) vo.setSearchCondition("TITLE");
      if(vo.getSearchKeyword() == null) vo.setSearchKeyword("");
      vo.setWriter((String)session.getAttribute("cid"));
      model.addAttribute("qnaList", qnaDAO.getQnAList(vo));
      return "getQnAList.jsp";
   }
   
   @ModelAttribute("conditionMap")
   public Map<String, String> searchCondtionMap(){
      Map<String, String> conditionMap = new HashMap<String, String>();
      conditionMap.put("제목", "TITLE");
      conditionMap.put("내용", "CONTENT");
      return conditionMap;
   }
   
   @RequestMapping("/lib_QnAList.do")
   public String lib_QnAList(QnAVO vo, QnADAO qnaDAO, Model model) {
	   System.out.println("도서관용 QnA 목록 조회 처리");
	   if(vo.getSearchCondition() == null) vo.setSearchCondition("TITLE");
	   if(vo.getSearchKeyword() == null) vo.setSearchKeyword("");
	   model.addAttribute("qnaList", qnaDAO.getQnAList_biz(vo));
	   return "lib_QnAList.jsp";
   }
   
   @RequestMapping("/lib_QnA.do")
   public String lib_QnA(ReplyDAO replyDAO, QnAVO vo, QnADAO qnaDAO, Model model) {
      System.out.println("도서관용 글 상세 조회 처리");
      model.addAttribute("qna", qnaDAO.getQnA(vo));
      model.addAttribute("replyList", replyDAO.getReply(vo));
      qnaDAO.upCnt(vo);
      return "lib_QnA.jsp";
   }
   
   @RequestMapping("/admin_QnAList.do")
   public String admin_QnAList(QnAVO vo, QnADAO qnaDAO, Model model) {
	   System.out.println("관리자용 QnA 목록 조회 처리");
	   if(vo.getSearchCondition() == null) vo.setSearchCondition("TITLE");
	   if(vo.getSearchKeyword() == null) vo.setSearchKeyword("");
	   model.addAttribute("qnaList", qnaDAO.getQnAList_biz(vo));
	   return "admin_QnAList.jsp";
   }
   
   @RequestMapping("/admin_QnA.do")
   public String admin_QnA(ReplyDAO replyDAO, QnAVO vo, QnADAO qnaDAO, Model model) {
      System.out.println("관리자용 글 상세 조회 처리");
      model.addAttribute("qna", qnaDAO.getQnA(vo));
      model.addAttribute("replyList", replyDAO.getReply(vo));
      qnaDAO.upCnt(vo);
      return "admin_QnA.jsp";
   }
}
