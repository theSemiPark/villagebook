package com.spring.biz.user;

public class UserVO {
	private String cid;
	private String cpw;
	private String cname;
	private int crank;
	private String chp;
	private String cpostcode;
	private String caddr1;
	private String caddr2;
	private int cpoint;
	private int careaid;
	private int ordmoney30;
	
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getCpw() {
		return cpw;
	}
	public void setCpw(String cpw) {
		this.cpw = cpw;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public int getCrank() {
		return crank;
	}
	public void setCrank(int crank) {
		this.crank = crank;
	}
	public String getChp() {
		return chp;
	}
	public void setChp(String chp) {
		this.chp = chp;
	}
	public String getCpostcode() {
		return cpostcode;
	}
	public void setCpostcode(String cpostcode) {
		this.cpostcode = cpostcode;
	}
	public String getCaddr1() {
		return caddr1;
	}
	public void setCaddr1(String caddr1) {
		this.caddr1 = caddr1;
	}
	public String getCaddr2() {
		return caddr2;
	}
	public void setCaddr2(String caddr2) {
		this.caddr2 = caddr2;
	}
	public int getCpoint() {
		return cpoint;
	}
	public void setCpoint(int cpoint) {
		this.cpoint = cpoint;
	}
	public int getCareaid() {
		return careaid;
	}
	public void setCareaid(int careaid) {
		this.careaid = careaid;
	}
	public int getOrdmoney30() {
		return ordmoney30;
	}
	public void setOrdmoney30(int ordmoney30) {
		this.ordmoney30 = ordmoney30;
	}
	@Override
	public String toString() {
		return "UserVO [cid=" + cid + ", cpw=" + cpw + ", cname=" + cname + ", crank=" + crank + ", chp=" + chp
				+ ", cpostcode=" + cpostcode + ", caddr1=" + caddr1 + ", caddr2=" + caddr2 + ", cpoint=" + cpoint
				+ ", careaid=" + careaid + "]";
	}	
	
}
