package com.spring.view.ctrl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.biz.libinfo.LibInfoDAO;
import com.spring.biz.libinfo.LibInfoVO;
import com.spring.biz.libuser.LibUserDAO;
import com.spring.biz.libuser.LibUserVO;

@Controller
public class LibInfoController {

	@RequestMapping(value = { "/getLibinfo.do", "/lib_otherInfo.do" }) // 사용자 페이지, 도서관 페이지에서의 도서관 정보보기 처리
	public ModelAndView handlerRequest(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			String lid) {
		System.out.println("도서관 정보 처리");

		LibInfoVO vo = new LibInfoVO();
		LibInfoDAO libinfoDAO = new LibInfoDAO();
		vo.setLid(lid);
		System.out.println(vo.getLid());
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("otherInfo", libinfoDAO.getLibList_admin());
		
		mav.addObject("libinfo", libinfoDAO.getLibInfoList(vo));
		
		if (request.getServletPath().equals("/getLibinfo.do")) {
			mav.setViewName("getLibinfo.jsp");
		} else if (request.getServletPath().equals("/lib_otherInfo.do")) {
			mav.setViewName("lib_otherInfo.jsp");
		} 

		return mav;
	}

	@RequestMapping(value = "/lib_myInfo.do", method = RequestMethod.GET)
	public String infoUpdate(LibUserVO vo, LibUserDAO userDAO, HttpSession session, Model model) {
		System.out.println("도서관 정보 수정 창으로 이동");
		model.addAttribute("lib", userDAO.getLibUser(vo));
		return "lib_myInfo.jsp";
	}

	@RequestMapping(value = "/lib_myInfo.do", method = RequestMethod.POST)
	public String updateLibUser(LibUserVO vo, LibUserDAO userDAO, HttpSession session) {
		System.out.println("도서관 정보 수정");
		vo.setLid((String) session.getAttribute("lid"));
		System.out.println("공휴일:" + vo.getLholiday());
		System.out.println("운영시간:" + vo.getLoperate());
		System.out.println("아이디: " + vo.getLid());
		userDAO.updateLibUser(vo);
		return "biz_login.jsp";
	}
	
	@RequestMapping(value = "/getLibList_admin.do")
	public String getLibList_admin(LibInfoDAO libDAO, Model model) {
		System.out.println("관리자용 도서관 정보 보기");
		model.addAttribute("libList", libDAO.getLibList_admin());
		return "getLibList_admin.jsp";
	}
	
	@RequestMapping(value = "/LibModify_admin.do", method = RequestMethod.GET)
	public String LibModify_admin(LibInfoDAO libDAO, LibInfoVO vo, Model model) {
		System.out.println("관리자용 도서관 수정1");
		model.addAttribute("lib", libDAO.getLibInfoList(vo));
		return "LibModify_admin.jsp";
	}
	
	@RequestMapping(value = "/LibModify_admin.do", method = RequestMethod.POST)
	public String LibModify_admin2(LibInfoDAO libDAO, LibInfoVO vo, Model model) {
		System.out.println("관리자용 도서관 수정2");
		System.out.println(vo);
		libDAO.libInfoModify(vo);
		return "getLibList_admin.do";
	}
}
