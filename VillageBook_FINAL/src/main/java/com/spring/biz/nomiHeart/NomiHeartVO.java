package com.spring.biz.nomiHeart;

public class NomiHeartVO {
	private int nheart;
	private long seq;
	private String sender;

	public int getNheart() {
		return nheart;
	}

	public void setNheart(int nheart) {
		this.nheart = nheart;
	}

	public long getSeq() {
		return seq;
	}

	public void setSeq(long seq) {
		this.seq = seq;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	@Override
	public String toString() {
		return "NomiHeartVO [nheart=" + nheart + ", seq=" + seq + ", sender=" + sender + "]";
	}

}
