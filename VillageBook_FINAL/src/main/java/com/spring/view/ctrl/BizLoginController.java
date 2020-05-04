package com.spring.view.ctrl;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.biz.libuser.LibUserDAO;
import com.spring.biz.libuser.LibUserVO;

@Controller
public class BizLoginController {

	@RequestMapping(value="/biz_login.do", method=RequestMethod.GET)
	public String loginView(@ModelAttribute("user") LibUserVO vo) {
		System.out.println("로그인 화면으로 이동");
		vo.setLid("admin");
		vo.setLpw("admin");
		return "biz_login.jsp";
	}
	
	//호연 수정. lib_myInfo 정보 불러오기위해 세션 값 추가
	@RequestMapping(value="/biz_login.do", method=RequestMethod.POST)
	public String login(LibUserVO vo, LibUserDAO userDAO, HttpSession session) {
		System.out.println("로그인 인증 처리");
		
		if(vo.getLid() == null) {
			throw new IllegalArgumentException("아이디는 반드시 입력해야 합니다.");
		}
		
		LibUserVO user = userDAO.getLibUser(vo);
		if(user != null){
			if(!user.getLid().equals("admin")) {
				userDAO.login(user.getLid());
			}
			session.setAttribute("lid", user.getLid());
			session.setAttribute("lname",user.getLname());
			session.setAttribute("ltel", user.getLtel());
			session.setAttribute("laddr", user.getLaddr());
			session.setAttribute("lholiday", user.getLholiday());
			session.setAttribute("loperate", user.getLoperate());
			
			if(user.getLid().equals("admin"))return "adminMainPage.do";
			else return "libraryMainPage.do";	
		}else {
			return "biz_login.jsp";
		}
	}
}
