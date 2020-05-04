package com.spring.view.ctrl;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.biz.user.UserDAO;
import com.spring.biz.user.UserVO;

@Controller
//@SessionAttributes("user")
public class JoinController{

	@RequestMapping(value="/join.do", method=RequestMethod.GET)
	public String joinView(@ModelAttribute("user") UserVO vo) {
		System.out.println("회원가입 화면으로 이동");
		return "join.jsp";
	}	

	@RequestMapping(value="/join.do", method=RequestMethod.POST)
	public String join(UserVO vo, UserDAO userDAO, HttpSession session) {
		System.out.println("회원 가입 처리");
		userDAO.insertUser(vo);
		userDAO.insertAreaid(vo);
		return "index.jsp";

	}

	@RequestMapping("/overCheck.do")
	public @ResponseBody String overCheck(UserDAO userDAO, String cid) {
		System.out.println("아이디 중복 체크");
		if(userDAO.overCheck(cid)) return "false";
		else return "true";
	}
}