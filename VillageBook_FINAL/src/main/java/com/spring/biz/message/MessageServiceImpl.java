package com.spring.biz.message;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("messageService")
public class MessageServiceImpl implements MessageService {
	
	@Autowired
	private MessageDAO messageDAO;

	@Override
	public List<MessageVO> getMessageList(MessageVO vo) {
		return messageDAO.getMessageList(vo);
	}

	@Override
	public MessageVO getMessage(MessageVO vo) {
		return messageDAO.getMessage(vo);
	}

	@Override
	public void insertMessage(MessageVO vo) {
		messageDAO.insertMessage(vo);
	}
	
	@Override
	public void deleteMessage(MessageVO vo) {
		messageDAO.deleteMessage(vo);
	}

	@Override
	public String checkMessage(MessageVO vo) {
		return messageDAO.checkMessage(vo);
	}

	@Override
	public List<MessageVO> getMsgList_biz(MessageVO vo) {
		return messageDAO.getMsgList_biz(vo);
	}

	@Override
	public Map<String, String> searchConditionMap_biz() {
		return messageDAO.searchCondtionMap_biz();
	}

	@Override
	public Map<String, String> searchConditionMap_user() {
		return messageDAO.searchCondtionMap_user();
	}
}
