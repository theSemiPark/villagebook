package com.spring.biz.message;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.spring.biz.common.JDBCUtil;

@Repository("messageDAO")
public class MessageDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;

	private final String GET_MSG_LIST = "SELECT * FROM MESSAGE WHERE TARGETID = ? ORDER BY SENDDATE DESC";
	private final String GET_MSG_LIST_BIZ = "SELECT * FROM MESSAGE WHERE SENDER = ? ORDER BY SENDDATE DESC";
	private final String GET_MSG = "SELECT * FROM MESSAGE WHERE MID = ?";
	private final String UPDATE_ODATE = "UPDATE MESSAGE SET OPENDATE = SYSDATE WHERE MID = ?";
	private final String CHECK_UNOPEN = "SELECT * FROM MESSAGE WHERE TARGETID = ? AND OPENDATE IS NULL";
	private final String DELETE_MSG = "DELETE FROM MESSAGE WHERE MID = ?";
	private final String INSERT_MSG = "INSERT INTO MESSAGE VALUES (M_SEQ.NEXTVAL, ?, ?, ?, NULL, SYSDATE)";
	private final String GET_BIZ_LIST = "SELECT LNAME FROM LIBRARY ORDER BY LNAME";
	private final String GET_USER_LIST = "SELECT CID FROM USER_INFO ORDER BY CID";

	public List<MessageVO> getMessageList(MessageVO vo) {
		System.out.println("===> JDBC로 getMessageList() 기능처리");
		List<MessageVO> messageList = new ArrayList<MessageVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(GET_MSG_LIST);
			stmt.setString(1, vo.getTargetid());

			rs = stmt.executeQuery();
			while (rs.next()) {
				MessageVO message = new MessageVO();
				message.setMid(rs.getInt("MID"));
				message.setSender(rs.getString("SENDER"));
				message.setTargetid(rs.getString("TARGETID"));
				message.setMessage(rs.getString("MESSAGE"));
				message.setSenddate(rs.getDate("SENDDATE"));
				message.setOpendate(rs.getDate("OPENDATE"));
				messageList.add(message);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return messageList;
	}

	public MessageVO getMessage(MessageVO vo) {
		System.out.println("===> JDBC로 getMessage() 기능처리");
		MessageVO message = new MessageVO();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(GET_MSG);
			stmt.setInt(1, vo.getMid());

			rs = stmt.executeQuery();
			if (rs.next()) {
				message.setMid(rs.getInt("MID"));
				message.setSender(rs.getString("SENDER"));
				message.setTargetid(rs.getString("TARGETID"));
				message.setMessage(rs.getString("MESSAGE"));
				message.setSenddate(rs.getDate("SENDDATE"));
				message.setOpendate(rs.getDate("OPENDATE"));
			}
			if(message.getOpendate() == null && vo.getTargetid() != null) {
				stmt = conn.prepareStatement(UPDATE_ODATE);
				stmt.setInt(1, vo.getMid());
				stmt.executeUpdate();
				
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		        String today = sdf.format(new java.util.Date());
		        Date d = Date.valueOf(today);
				message.setOpendate(d);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return message;
	}

	public void insertMessage(MessageVO vo) {
		System.out.println("===> JDBC로 insertMessage() 기능처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(INSERT_MSG);
			stmt.setString(1, vo.getTargetid());
			stmt.setString(2, vo.getSender());
			stmt.setString(3, vo.getMessage());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}

	}

	public void deleteMessage(MessageVO vo) {
		System.out.println("===> JDBC로 deleteMessage() 기능처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(DELETE_MSG);
			stmt.setInt(1, vo.getMid());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}

	public String checkMessage(MessageVO vo) {
		System.out.println("===> JDBC로 checkMessage() 기능처리");
		String result = "N";
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(CHECK_UNOPEN);
			stmt.setString(1, vo.getTargetid());
			rs = stmt.executeQuery();
			
			if(rs.next()) result = "Y";
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return result;
	}

	public List<MessageVO> getMsgList_biz(MessageVO vo) {
		System.out.println("===> JDBC로 getMsgList_biz() 기능처리");
		List<MessageVO> messageList = new ArrayList<MessageVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(GET_MSG_LIST_BIZ);
			stmt.setString(1, vo.getSender());

			rs = stmt.executeQuery();
			while (rs.next()) {
				MessageVO message = new MessageVO();
				message.setMid(rs.getInt("MID"));
				message.setSender(rs.getString("SENDER"));
				message.setTargetid(rs.getString("TARGETID"));
				message.setMessage(rs.getString("MESSAGE"));
				message.setSenddate(rs.getDate("SENDDATE"));
				message.setOpendate(rs.getDate("OPENDATE"));
				messageList.add(message);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return messageList;
	}
	
	public Map<String, String> searchCondtionMap_biz(){
		Map<String, String> conditionMap = new LinkedHashMap<String, String>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(GET_BIZ_LIST);
			rs = stmt.executeQuery();
			while (rs.next()) {
				String lname = rs.getString("lname");
				conditionMap.put(lname, lname);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return conditionMap;
		
	}
	
	public Map<String, String> searchCondtionMap_user(){
		Map<String, String> conditionMap = new LinkedHashMap<String, String>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(GET_USER_LIST);
			rs = stmt.executeQuery();
			while (rs.next()) {
				String cid = rs.getString("cid");
				conditionMap.put(cid, cid);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return conditionMap;
		
	}
}
