package com.spring.view.ctrl;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.spring.biz.nomiHeart.NomiHeartService;
import com.spring.biz.nomiHeart.NomiHeartVO;

@Controller
public class NomiHeartController {

	@Autowired
	private NomiHeartService nomiHeartService;

	@RequestMapping("/insertNomiHeart.do")
	public String insertNomiHeart(HttpSession session, NomiHeartVO vo) {
		System.out.println("좋아요 처리");
		if((String) session.getAttribute("cid") != null) vo.setSender((String) session.getAttribute("cid"));
		else vo.setSender((String) session.getAttribute("lid"));
		System.out.println(vo.getSeq() + ":" + vo.getSender());
		nomiHeartService.insertNomiHeart(vo);
		return "";
	}

	@RequestMapping("/deleteNomiHeart.do")
	public String getMessage(HttpSession session, NomiHeartVO vo) {
		System.out.println("좋아요 취소");
		if((String) session.getAttribute("cid") != null) vo.setSender((String) session.getAttribute("cid"));
		else vo.setSender((String) session.getAttribute("lid"));
		nomiHeartService.deleteNomiHeart(vo);
		return "";
	}
}
