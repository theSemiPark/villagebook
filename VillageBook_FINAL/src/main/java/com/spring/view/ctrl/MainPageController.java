package com.spring.view.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.biz.book.BookDAO;
import com.spring.biz.book.BookVO;
import com.spring.biz.user.UserDAO;
import com.spring.biz.user.UserVO;

@Controller
//@SessionAttributes("user")
public class MainPageController{

	@RequestMapping(value="/mainPage.do", method=RequestMethod.GET)
	public String mainView(@ModelAttribute("user") UserVO vo, UserDAO userDAO, HttpSession session) {
		System.out.println("메인 화면으로 이동");
		return "mainPage.jsp";
	}	

	@RequestMapping(value="/mainPage.do", method=RequestMethod.POST)
	public String mainPage(BookVO vo, BookDAO bookDAO,Model model) {
		System.out.println("메인 화면 처리");
		
		if(vo.getSearchCondition() == null) vo.setSearchCondition("BOOKNAME");
		if(vo.getSearchKeyword() == null) vo.setSearchKeyword("");
		
		model.addAttribute("bookList", bookDAO.getBookList(vo));
		return "mainPage.jsp";
	}
	
	@ModelAttribute("conditionMapMain")
	public Map<String, String> searchCondtionMap(){
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("책제목", "BOOKNAME");
		conditionMap.put("저자", "AUTHOR");
		conditionMap.put("출판사", "PUBLISHER");
		conditionMap.put("카테고리", "GENRE");
		return conditionMap;
	}
	
}