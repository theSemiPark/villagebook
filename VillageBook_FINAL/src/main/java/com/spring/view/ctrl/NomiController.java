package com.spring.view.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.biz.nomi.NomiDAO;
import com.spring.biz.nomi.NomiVO;

@Controller
@SessionAttributes("nomi")
public class NomiController {
	static int cnt=0;
	
   @RequestMapping("/insertNomi.do")
   public String insertNomi(NomiVO vo, NomiDAO nomiDAO) {
      System.out.println("글 등록 처리");
      
      nomiDAO.insertNomi(vo);
      return "getNomiList.do";      
   }
   
   @RequestMapping("/updateNomi.do")
   public String updateNomi(NomiVO vo, NomiDAO nomiDAO) {
      System.out.println("글 수정 처리");
      
      nomiDAO.updateNomi(vo, cnt);
      return "getNomi.do";      
   }
   
   @RequestMapping("/updateNomiByAdmin.do")
   public String updateNomiByAdmin(NomiVO vo, NomiDAO nomiDAO) {
      System.out.println("글 수정 처리 by 중앙관리자");
      
      nomiDAO.updateNomiByAdmin(vo, cnt);
      return "getNomi.do";      
   }
   
   @RequestMapping("/editNomi.do")
   public String editNomi(NomiVO vo, NomiDAO nomiDAO,HttpSession session) {
      System.out.println("글 수정 폼으로 이동");
      
      nomiDAO.editNomi(vo);
      return "editNomi.jsp";      
   }
   
   
   @RequestMapping("/deleteNomi.do")
   public String deleteNomi(NomiVO vo, NomiDAO nomiDAO) {
      System.out.println("글 삭제 처리");

      nomiDAO.deleteNomi(vo);
      return "getNomiList.do"; 
   }
   
   @RequestMapping("/getNomi.do")
   public String getNomi(HttpSession session, NomiVO vo, NomiDAO nomiDAO, Model model) {
      System.out.println("글 상세 조회 처리");
      String reader = (String)session.getAttribute("cid");
      if(reader == null) reader = (String)session.getAttribute("lid");
      nomiDAO.upCnt(vo);
      model.addAttribute("nomi", nomiDAO.getNomi(vo, reader));

      return "getNomi.jsp";
   }
   
   @RequestMapping("/getNomiList.do")
   public String getNomiList(NomiVO vo, NomiDAO nomiDAO, Model model) {
      System.out.println("글 목록 조회 처리");
      
      if(vo.getSearchCondition() == null) vo.setSearchCondition("TITLE");
      if(vo.getSearchKeyword() == null) vo.setSearchKeyword("");
      
      model.addAttribute("nomiList", nomiDAO.getNomiList(vo));
      return "getNomiList.jsp";
   }
   
   @ModelAttribute("conditionMap")
   public Map<String, String> searchCondtionMap(){
      Map<String, String> conditionMap = new HashMap<String, String>();
      conditionMap.put("제목", "TITLE");
      conditionMap.put("내용", "CONTENT");
      return conditionMap;
   }
   
   
}
