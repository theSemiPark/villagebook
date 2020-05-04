package com.spring.view.ctrl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.biz.mileage.MileageDAO;
import com.spring.biz.mileage.MileageVO;

@Controller
public class GetMileageController {
	
	@RequestMapping("/getMileageList.do")
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("마일리지 목록 처리");
		
		MileageVO vo = new MileageVO();
		MileageDAO mileageDAO = new MileageDAO();
		List<MileageVO> mileageList = mileageDAO.getMileageList(vo);
		
		HttpSession session = request.getSession();
		session.setAttribute("mileageList", mileageList);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("mileageList", mileageList);
		mav.setViewName("getMileageList.jsp");
		return mav;
	}

}
