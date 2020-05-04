package com.spring.biz.delivery;

import java.sql.Date;

public class DeliveryVO {
	private long ordid;
	private long isbn;
	private String cid;
	private String lid;
	private long ordercnt;
	private long ordmoney;
	private Date orderdate;
	private Date startdate;
	private Date returndate;
	private long shipping;
	private String renewtf;
	private String returnwer;
	private String bookname;
	private String lname;
	private int shipcnt;
	private int retcnt;

	private String searchCondition;
	private String searchKeyword;
	
	public long getOrdid() {
		return ordid;
	}
	public void setOrdid(long ordid) {
		this.ordid = ordid;
	}
	public long getIsbn() {
		return isbn;
	}
	public void setIsbn(long isbn) {
		this.isbn = isbn;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getLid() {
		return lid;
	}
	public void setLid(String lid) {
		this.lid = lid;
	}
	public long getOrdercnt() {
		return ordercnt;
	}
	public void setOrdercnt(long ordercnt) {
		this.ordercnt = ordercnt;
	}
	public long getOrdmoney() {
		return ordmoney;
	}
	public void setOrdmoney(long ordmoney) {
		this.ordmoney = ordmoney;
	}
	public Date getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getReturndate() {
		return returndate;
	}
	public void setReturndate(Date returndate) {
		this.returndate = returndate;
	}
	public long getShipping() {
		return shipping;
	}
	public void setShipping(long shipping) {
		this.shipping = shipping;
	}
	public String getRenewtf() {
		return renewtf;
	}
	public void setRenewtf(String renewtf) {
		this.renewtf = renewtf;
	}
	public String getReturnwer() {
		return returnwer;
	}
	public void setReturnwer(String returnwer) {
		this.returnwer = returnwer;
	}
	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	
	public int getShipcnt() {
		return shipcnt;
	}
	public void setShipcnt(int shipcnt) {
		this.shipcnt = shipcnt;
	}
	
	public int getRetcnt() {
		return retcnt;
	}
	public void setRetcnt(int retcnt) {
		this.retcnt = retcnt;
	}
	
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	@Override
	public String toString() {
		return "BoardVO [ordid=" + ordid + ", isbn=" + isbn + ", cid=" + cid + ", lid=" + lid + ", ordercnt=" + ordercnt
				+ ", ordmoney=" + ordmoney + ", orderdate=" + orderdate + ", startdate=" + startdate + ", returndate="
				+ returndate + ", shipping=" + shipping + ", renewtf=" + renewtf + ", returnwer=" + returnwer
				+ ", bookname=" + bookname + "]";
	}
}