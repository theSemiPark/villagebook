package com.spring.biz.message;

import java.util.List;
import java.util.Map;

public interface MessageService {

	List<MessageVO> getMessageList(MessageVO vo);
	MessageVO getMessage(MessageVO vo);
	void insertMessage(MessageVO vo);
	void deleteMessage(MessageVO vo);
	String checkMessage(MessageVO vo);
	List<MessageVO> getMsgList_biz(MessageVO vo);
	Map<String, String> searchConditionMap_biz();
	Map<String, String> searchConditionMap_user();
}
