package com.spring.biz.rental;

import java.util.Date;

public class RentalVO {
	private String lid;
	private Date orderdate;
	private String bookname;
	private String cname;
	private String cid;
	private long isbn;
	private int rcnt;
	private int havecnt;
	private int ordercnt;

	public String getLid() {
		return lid;
	}

	public void setLid(String lid) {
		this.lid = lid;
	}

	public Date getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}

	public String getBookname() {
		return bookname;
	}

	public void setBookname(String bookname) {
		this.bookname = bookname;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public long getIsbn() {
		return isbn;
	}

	public void setIsbn(long isbn) {
		this.isbn = isbn;
	}

	public int getRcnt() {
		return rcnt;
	}

	public void setRcnt(int rcnt) {
		this.rcnt = rcnt;
	}

	public int getHavecnt() {
		return havecnt;
	}

	public void setHavecnt(int havecnt) {
		this.havecnt = havecnt;
	}

	public int getOrdercnt() {
		return ordercnt;
	}

	public void setOrdercnt(int ordercnt) {
		this.ordercnt = ordercnt;
	}

	@Override
	public String toString() {
		return "RentalVO [lid=" + lid + ", orderdate=" + orderdate + ", bookname=" + bookname + ", cname=" + cname
				+ ", cid=" + cid + ", isbn=" + isbn + ", rcnt=" + rcnt + ", havecnt=" + havecnt + ", ordercnt="
				+ ordercnt + "]";
	}

}
