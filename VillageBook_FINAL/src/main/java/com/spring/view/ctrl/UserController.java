package com.spring.view.ctrl;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.biz.user.UserDAO;
import com.spring.biz.user.UserVO;

@Controller
public class UserController {

	@RequestMapping(value = "/insertUser.do")
	public String insertUser(UserVO vo, UserDAO UserDAO) {
		System.out.println("회원 등록 처리");
		return "mainPage.jsp";
	}

	// 회원 정보 수정 가능여부 확인
	@RequestMapping(value = "/checkUpdate.do", method = RequestMethod.POST)
	public @ResponseBody String checkUpdate(UserVO vo, UserDAO userDAO, HttpSession session) {
		vo.setCid((String) session.getAttribute("cid"));
		UserVO user = userDAO.getUser(vo);
		if (user != null)
			return "true";
		else
			return "false";
	}

	// 회원 정보 수정 처리
	@RequestMapping(value = "/updateUser.do", method = RequestMethod.POST)
	public String updateUser(UserVO vo, UserDAO userDAO, String pw_change, String new_cpw, HttpSession session) {
		System.out.println("회원정보 수정 처리");
		if (pw_change != null)
			vo.setCpw(new_cpw);
		vo.setCid((String) session.getAttribute("cid"));
		System.out.println("ID: " + vo.getCid());
		System.out.println("PW: " + vo.getCpw());
		System.out.println("이름: " + vo.getCname());
		System.out.println("전화번호: " + vo.getChp());
		System.out.println("주소: " + vo.getCpostcode() + " " + vo.getCaddr1() + " " + vo.getCaddr2());
		userDAO.updateUser(vo);
		userDAO.insertAreaid(vo);
		return "login.jsp";
	}

	@RequestMapping("/getRanks.do")
	public String getRanks(UserDAO userDAO, Model model) {
		System.out.println("회원랭킹 관리 for BlackList");
		model.addAttribute("rankList", userDAO.getRankList());
		return "getRankList.jsp";
	}

	@RequestMapping("/rankUpdate.do")
	public String rankUpdate(UserDAO userDAO, UserVO vo, int oldRank) {
		System.out.println("랭킹 업데이트");
		userDAO.rankUpdate(vo, oldRank);
		return "getRanks.do";
	}
	
	@RequestMapping("/pointUpdate.do")
	public String pointViewClick(@ModelAttribute("point") UserVO vo, HttpSession session) {
		System.out.println("포인트 조정 창으로 이동");
		System.out.println("포인트: " + vo.getCpoint());
		session.setAttribute("point", vo);
		return "pointUpdate.jsp";
	}

	@RequestMapping("/pointUpdates.do")
	public String updatePoint(UserVO vo, UserDAO userDAO, HttpSession session, Model model) {
		System.out.println("포인트 조정 처리");
		System.out.println("회원명: " + vo.getCname());
		System.out.println("포인트 : " + vo.getCpoint());
		UserVO p = (UserVO)session.getAttribute("point");
		vo.setCid(p.getCid());
		int old = p.getCpoint();
		userDAO.updatePoint(vo, old);
		return "getRanks.do";
	}

}
