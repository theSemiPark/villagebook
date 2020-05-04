package com.spring.view.ctrl;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.biz.libuser.LibUserDAO;
import com.spring.biz.user.UserDAO;

@Controller
public class LogoutController {

	@RequestMapping("/logout.do")
	public String Logout(HttpSession session, UserDAO userDAO, LibUserDAO libDAO) {
		System.out.println("로그아웃 처리");

		String id = (String)session.getAttribute("cid");
		if(id!="" && id!= null) {
			userDAO.logout(id);
		} else {
			id = (String)session.getAttribute("lid");
			if(id!="admin") libDAO.logout(id);
		}
		session.invalidate();
		return "index.jsp";
	}

}
