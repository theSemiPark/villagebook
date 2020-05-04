package com.spring.view.ctrl;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.biz.point.PointDAO;
import com.spring.biz.point.PointService;
import com.spring.biz.point.PointVO;
import com.spring.biz.user.UserDAO;
import com.spring.biz.user.UserVO;

@Controller
public class PointController {
	@Autowired
	private PointService pointService;
	
	@RequestMapping("/insertPoint.do")
	public String insertpoint(HttpSession session, PointDAO pointDAO, PointVO vo) {
		int sum = (int) session.getAttribute("sum");
		int usepoint = (int) session.getAttribute("usepoint");
		UserVO user = (UserVO)session.getAttribute("user");
		int rank = user.getCrank();

		if (rank >= 3) vo.setPlusp((int)(sum*0.05));
		else vo.setPlusp((int)(sum*0.03));
		vo.setMinusp(usepoint);

		vo.setCid((String)session.getAttribute("cid"));
		vo.setOrdid((long)session.getAttribute("ordid"));

		pointService.insertPoint(vo);
		System.out.println("insertPoint done");
		return "paydone.jsp";
	}
	
	@RequestMapping("/getPoints.do")
	public String getpoints(Model model, HttpSession session, UserVO user, UserDAO userDAO){
		
		//UserVO user = new UserVO();
		user.setCid((String) session.getAttribute("cid"));
		user = userDAO.getUserInfo(user);
		session.setAttribute("user", user);
		
		model.addAttribute("pointList", pointService.getPoints((String)session.getAttribute("cid")));
		return "getPointList.jsp";
	}
}