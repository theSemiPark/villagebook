package com.spring.view.ctrl;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.biz.message.MessageService;
import com.spring.biz.message.MessageVO;

@Controller
public class MessageController {

	@Autowired
	private MessageService messageService;

	@RequestMapping("/getMessageList.do")
	public String getMessageList(HttpSession session, MessageVO vo, Model model) {
		System.out.println("메시지리스트  조회 처리");

		vo.setTargetid((String) session.getAttribute("cid"));
		model.addAttribute("messageList", messageService.getMessageList(vo));

		return "getMessageList.jsp";
	}
	
	@RequestMapping("/getMessage.do")
	public String getMessage(HttpSession session, MessageVO vo, Model model) {
		System.out.println("메시지  조회 처리");
		vo.setTargetid((String)session.getAttribute("cid"));
		model.addAttribute("message", messageService.getMessage(vo));

		return "getMessage.jsp";
	}
	
	@RequestMapping("/checkMessage.do")
	public @ResponseBody String checkMessage(HttpSession session, MessageVO vo, Model model) {
		System.out.println("미확인 메시지여부 처리");
		if(session.getAttribute("cid") != null) vo.setTargetid((String) session.getAttribute("cid"));
		else vo.setTargetid((String) session.getAttribute("lname"));
		System.out.println(vo.getTargetid());
		String result = messageService.checkMessage(vo);
		System.out.println("result: " + result);
		return result;
	}
	
	@RequestMapping("/deleteMessage.do")
	public String deleteMessage(HttpSession session, MessageVO vo) {
		System.out.println("메시지 삭제");

		messageService.deleteMessage(vo);
		if(session.getAttribute("cid") != null) return "getMessageList.do";
		else return "getMsgList_biz.do";
	}
	
	@RequestMapping("/getMsgList_biz.do")
	public String getMsgList_biz(HttpSession session, MessageVO vo, Model model){
		System.out.println("관리자용 메시지리스트 조회 처리");
		vo.setSender((String)session.getAttribute("lname"));
		model.addAttribute("messageList", messageService.getMsgList_biz(vo));
		vo.setTargetid((String)session.getAttribute("lname"));
		model.addAttribute("receiveList", messageService.getMessageList(vo));
		return "getMsgList_biz.jsp";
	}
	
	@RequestMapping("/getMsg_biz.do")
	public String getMsg_biz(HttpSession session, MessageVO vo, Model model){
		System.out.println("관리자용 메시지 조회 처리");
		model.addAttribute("message", messageService.getMessage(vo));
		return "getMsg_biz.jsp";
	}
	
	@RequestMapping("/getRecMsg_biz.do")
	public String getRecMsg_biz(HttpSession session, MessageVO vo, Model model){
		System.out.println("관리자용 받은메시지 조회 처리");
		vo.setTargetid((String)session.getAttribute("lname"));
		model.addAttribute("message", messageService.getMessage(vo));
		return "getMsg_biz.jsp";
	}
	
	@RequestMapping(value = "/insertMessage.do", method=RequestMethod.GET)
	public String insertMessage0(HttpSession session, MessageVO vo, Model model){
		return "insertMessage.jsp";
	}
	
	@RequestMapping(value = "/insertMessage.do", method=RequestMethod.POST)
	public String insertMessage(HttpSession session, MessageVO vo, Model model){
		System.out.println("관리자용 메시지 입력 처리");
		vo.setSender((String)session.getAttribute("lname"));
		messageService.insertMessage(vo);
		return "getMsgList_biz.do";
	}
	
	@ModelAttribute("conditionMap_biz")
	public Map<String, String> searchCondtionMap_biz(){
		Map<String, String> conditionMap = messageService.searchConditionMap_biz();
		return conditionMap;
	}
	
	@ModelAttribute("conditionMap_user")
	public Map<String, String> searchCondtionMap_user(){
		Map<String, String> conditionMap = messageService.searchConditionMap_user();
		return conditionMap;
	}
}
