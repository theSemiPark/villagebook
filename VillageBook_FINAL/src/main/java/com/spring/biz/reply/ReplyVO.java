package com.spring.biz.reply;

import java.sql.Date;

public class ReplyVO {
	private long qreplyid;
	private long seq;
	private String writer;
	private Date regdate;
	private String rcontent;
	
	public long getQreplyid() {
		return qreplyid;
	}
	public void setQreplyid(long qreplyid) {
		this.qreplyid = qreplyid;
	}
	public long getSeq() {
		return seq;
	}
	public void setSeq(long seq) {
		this.seq = seq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
}
