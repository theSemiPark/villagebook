package com.spring.view.ctrl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.biz.notice.NoticeDAO;
import com.spring.biz.notice.NoticeVO;
import com.spring.biz.reply.ReplyDAO;

@Controller
public class NoticeController {

   @RequestMapping("/insertNotice.do")
   public String insertNotice(NoticeVO vo, NoticeDAO noticeDAO) {
      System.out.println("글 등록 처리");
      
      noticeDAO.insertNotice(vo);
      return "getNoticeList.do";      
   }
   
   @RequestMapping("/deleteNotice.do")
   public String deleteQnA(NoticeVO vo, NoticeDAO noticeDAO) {
      System.out.println("글 삭제 처리");

      noticeDAO.deleteNotice(vo);
      return "getNoticeList.do"; 
   }  
   
   @RequestMapping("/getNotice.do")
   public String getNotice(ReplyDAO replyDAO, NoticeVO vo, NoticeDAO noticeDAO, Model model) {
      System.out.println("글 상세 조회 처리");
      
      noticeDAO.upCnt(vo);
      model.addAttribute("notice", noticeDAO.getNotice(vo));
      model.addAttribute("replyList", replyDAO.getReply_notice(vo));
      
      return "getNotice.jsp";
   }
   
   @RequestMapping("/getNoticeList.do")
   public String getNoticeList(NoticeVO vo, NoticeDAO noticeDAO, Model model) {
      System.out.println("글 목록 조회 처리");
      
      if(vo.getSearchCondition() == null) vo.setSearchCondition("TITLE");
      if(vo.getSearchKeyword() == null) vo.setSearchKeyword("");
      
      model.addAttribute("noticeList", noticeDAO.getNoticeList(vo));
      return "getNoticeList.jsp";
   }
   
   @ModelAttribute("conditionMap")
   public Map<String, String> searchCondtionMap(){
      Map<String, String> conditionMap = new HashMap<String, String>();
      conditionMap.put("제목", "TITLE");
      conditionMap.put("내용", "CONTENT");
      return conditionMap;
   }
   
   
}
