package com.spring.view.ctrl;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.biz.qna.QnADAO;
import com.spring.biz.reply.ReplyDAO;
import com.spring.biz.reply.ReplyVO;

@Controller
public class ReplyController {
	@RequestMapping("/insertReply.do")
	public String insertReply(QnADAO qnaDAO, ReplyDAO replyDAO, ReplyVO vo, HttpSession session) {
		System.out.println("댓글 입력");
		String cid = (String) session.getAttribute("cid");
		if (cid != null)
			vo.setWriter(cid);
		else
			vo.setWriter((String) session.getAttribute("lname"));
		replyDAO.insertReply(vo);
		if (cid == null)
			qnaDAO.updateReplyTF(vo);
		return "getQnA.jsp";
	}

	@RequestMapping("/deleteReply.do")
	public String deleteReply(ReplyDAO replyDAO, ReplyVO vo, HttpSession session) {
		System.out.println("댓글 삭제");
		replyDAO.deleteReply(vo);
		return "getQnA.jsp";
	}
	
	@RequestMapping("/insertReply_notice.do")
	public String insertReply_notice(QnADAO qnaDAO, ReplyDAO replyDAO, ReplyVO vo, HttpSession session) {
		System.out.println("공지사항 댓글 입력");
		String cid = (String) session.getAttribute("cid");
		if (cid != null)
			vo.setWriter(cid);
		else
			vo.setWriter((String) session.getAttribute("lname"));
		replyDAO.insertReply_notice(vo);
		return "getNotice.jsp";
	}

	@RequestMapping("/deleteReply_notice.do")
	public String deleteReply_notice(ReplyDAO replyDAO, ReplyVO vo, HttpSession session) {
		System.out.println("공지사항 댓글 삭제");
		replyDAO.deleteReply_notice(vo);
		return "getNotice.jsp";
	}
}
