package com.spring.view.ctrl;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.biz.user.UserDAO;
import com.spring.biz.user.UserVO;

@Controller
public class LoginController{

	@RequestMapping(value="/login.do", method=RequestMethod.GET)
	public String loginView(@ModelAttribute("user") UserVO vo) {
		System.out.println("로그인 화면으로 이동");
		vo.setCid("test");
		vo.setCpw("test123");
		return "login.jsp";
	}
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public String login(UserVO vo, UserDAO userDAO, HttpSession session) {
		System.out.println("로그인 인증 처리");
		
		if(vo.getCid() == null || vo.getCid().equals("")) {
			throw new IllegalArgumentException("아이디는 반드시 입력해야 합니다.");
		}
		
		UserVO user = userDAO.getUser(vo);
		if(user != null){
			userDAO.login(user.getCid());
			session.setAttribute("cid", user.getCid());
			session.setAttribute("cname", user.getCname());
			session.setAttribute("chp", user.getChp());
			session.setAttribute("cpostcode", user.getCpostcode());
			session.setAttribute("caddr1", user.getCaddr1());
			session.setAttribute("caddr2", user.getCaddr2());
			return "mainPage.do";	
		}else {
			return "login.jsp";
		}
	}
}