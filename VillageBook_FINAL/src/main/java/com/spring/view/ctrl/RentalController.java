package com.spring.view.ctrl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.biz.rental.RentalDAO;
import com.spring.biz.rental.RentalVO;

@Controller
public class RentalController {

	@RequestMapping("/lib_rentalBook.do")
	public ModelAndView handleRequest(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		System.out.println("대여관리 처리");

		RentalVO vo = new RentalVO();
		RentalDAO rentalDAO = new RentalDAO();
		vo.setLid((String) session.getAttribute("lid"));
		List<RentalVO> rentalList = rentalDAO.getRentalList(vo);

		// HttpSession session = request.getSession();
		session.setAttribute("rentalList", rentalList);

		ModelAndView mav = new ModelAndView();
		mav.addObject("rentalList", rentalList);
		mav.setViewName("lib_rentalBook.jsp");
		
		return mav;
	}
	
	@RequestMapping("/lib_rentalStatus.do")
	public String getRentalStatus(RentalDAO rentalDAO, RentalVO vo2, HttpSession session, Model model) {
		System.out.println("대여현황, 회원 처리");
		vo2.setLid((String)session.getAttribute("lid"));
		List<RentalVO> rentalStatus = rentalDAO.getRentalStatus(vo2);
		model.addAttribute("rentalStatus", rentalStatus);
		return "lib_rentalStatus.jsp";
	}


}
