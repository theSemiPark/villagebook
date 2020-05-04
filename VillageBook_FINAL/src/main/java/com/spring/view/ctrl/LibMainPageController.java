package com.spring.view.ctrl;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


import com.spring.biz.delivery.DeliveryDAO;
import com.spring.biz.delivery.DeliveryDAO2;
import com.spring.biz.delivery.DeliveryVO;
import com.spring.biz.rental.RentalDAO;
import com.spring.biz.rental.RentalVO;


@Controller
public class LibMainPageController {

	@RequestMapping("/libraryMainPage.do")
	public String mainView(@ModelAttribute("user") RentalVO rentalVO, RentalDAO rentalDAO, DeliveryVO deliveryVO, DeliveryDAO2 dao2, DeliveryDAO dao,HttpSession session, Model model) {
		System.out.println("메인 화면으로 이동");
		model.addAttribute("newOrder", dao2.getNewOrder());
		rentalVO.setLid((String)session.getAttribute("lid"));
		model.addAttribute("BestBook",rentalDAO.getBestBook(rentalVO));
		System.out.println(rentalDAO.getBestBook(rentalVO));
		
		deliveryVO.setShipping(2);
		deliveryVO.setReturnwer("N");
		model.addAttribute("ship2", dao.getDelivery_adminMain(deliveryVO));
		
		deliveryVO.setLid((String)session.getAttribute("lid"));
		model.addAttribute("returnY", dao2.lib_getReturnList(deliveryVO));
		
		return "libraryMainPage.jsp";
	}	


}
