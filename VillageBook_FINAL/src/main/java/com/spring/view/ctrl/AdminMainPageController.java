package com.spring.view.ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.biz.delivery.DeliveryDAO;
import com.spring.biz.delivery.DeliveryDAO2;
import com.spring.biz.delivery.DeliveryVO;

@Controller
public class AdminMainPageController {
	@RequestMapping("/adminMainPage.do")
	public String mainPage(DeliveryVO vo, DeliveryDAO2 deliveryDAO2, DeliveryDAO deliveryDAO, Model model) {
		System.out.println("메인 화면 처리");
		model.addAttribute("newOrder", deliveryDAO2.getNewOrder());
		vo.setShipping(-1);
		model.addAttribute("ship0",deliveryDAO.getDelivery_adminMain(vo));
		vo.setShipping(1);
		model.addAttribute("ship1",deliveryDAO.getDelivery_adminMain(vo));
		vo.setShipping(2);
		vo.setReturnwer("N");
		model.addAttribute("ship2",deliveryDAO.getDelivery_adminMain(vo));
		vo.setReturnwer("R");
		model.addAttribute("returnR",deliveryDAO.getDelivery_adminMain(vo));
		vo.setReturnwer("Y");
		model.addAttribute("returnY",deliveryDAO.getDelivery_adminMain(vo));
		return "adminMainPage.jsp";
	}
}
