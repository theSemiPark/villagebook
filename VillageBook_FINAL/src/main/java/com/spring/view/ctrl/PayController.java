package com.spring.view.ctrl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.biz.delivery.DeliveryDAO;
import com.spring.biz.delivery.DeliveryListVO;
import com.spring.biz.delivery.DeliveryVO;
import com.spring.biz.user.UserDAO;
import com.spring.biz.user.UserVO;

@Controller
public class PayController {

	@RequestMapping("/usePoint.do")
	public String usepoint(HttpSession session, int usepoint) {
		int sum = (int)session.getAttribute("sum");
		session.setAttribute("fi", sum-usepoint);
		session.setAttribute("usepoint", usepoint);
		return "getCart.do";
	}

	@RequestMapping("/order.do")
	public String order(DeliveryListVO list, int sum, Model model, HttpSession session, UserVO user, UserDAO userDAO) {
		List<DeliveryVO> list2 = list.getList();
		for (DeliveryVO a : list2)
			System.out.println(a.getLid());
		
		user = userDAO.getUserInfo(user);
		session.setAttribute("list", list);
		session.setAttribute("sum", sum);
		session.setAttribute("fi", sum);
		session.setAttribute("usepoint", 0);
		return "order.jsp";
	}

	@RequestMapping(value = "/paid.do", method = RequestMethod.POST)
	public String payment(HttpSession session, DeliveryDAO deliveryDAO, Model model) throws Exception {
		int sum = (int) session.getAttribute("sum");
		int usepoint = (int) session.getAttribute("usepoint");
		DeliveryListVO list = (DeliveryListVO) session.getAttribute("list");
		long ordid = deliveryDAO.insertDelivery(list, sum, usepoint);
		session.setAttribute("ordid", ordid);
		return "insertPoint.do";
	}
}