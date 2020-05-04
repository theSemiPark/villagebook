package com.spring.view.ctrl;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.biz.reserve.ReserveService;
import com.spring.biz.reserve.ReserveVO;

@Controller
public class ReserveController {
	@Autowired
	private ReserveService reserveService;

	@RequestMapping("/insertReserve.do")
	@ResponseBody
	public String insertReserve(ReserveVO vo, HttpSession session) throws IOException {
		vo.setCid((String) session.getAttribute("cid"));
		char ok = reserveService.insertReserve(vo);
		if (ok == '2') return "true";
		else if(ok == '1') return "already";
		else return "false";
	}
	
	@RequestMapping("/lib_reserve.do")
	public String reserveList(ReserveVO vo, HttpSession session, Model model) throws IOException {
		String lid = (String)session.getAttribute("lid");
		vo.setLid(lid);
		List<ReserveVO> list = reserveService.getReserveList_lib(vo);
		model.addAttribute("reserveList", list);
		return "lib_reserve.jsp";
	}
	
	@RequestMapping("/deleteReserve.do")
	public String deleteReserve(ReserveVO vo, HttpSession session) throws IOException{
		if(vo.getLid() == null) {
			String lid = (String)session.getAttribute("lid");
			vo.setLid(lid);
		}
		reserveService.deleteReserve(vo);
		return "lib_reserve.do";
	}
	
	@RequestMapping("/getReserveList.do")
	public String getReserveList(ReserveVO vo, HttpSession session, Model model) throws IOException{
		String cid = (String)session.getAttribute("cid");
		vo.setCid(cid);
		List<ReserveVO> list = reserveService.getReserveList(vo);
		model.addAttribute("reserveList", list);
		return "getReserveList.jsp";
	}
}
