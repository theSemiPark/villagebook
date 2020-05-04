package com.spring.biz.libuser;

public class LibUserVO {
	private String lid;
	private String lpw;
	private String lname;
	private String ltel;
	private String laddr;
	private String lholiday;
	private String loperate;
	private int llogin;
	
	public String getLid() {
		return lid;
	}
	public void setLid(String lid) {
		this.lid = lid;
	}
	public String getLpw() {
		return lpw;
	}
	public void setLpw(String lpw) {
		this.lpw = lpw;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getLtel() {
		return ltel;
	}
	public void setLtel(String ltel) {
		this.ltel = ltel;
	}
	public String getLaddr() {
		return laddr;
	}
	public void setLaddr(String laddr) {
		this.laddr = laddr;
	}
	public String getLholiday() {
		return lholiday;
	}
	public void setLholiday(String lholiday) {
		this.lholiday = lholiday;
	}
	public String getLoperate() {
		return loperate;
	}
	public void setLoperate(String loperate) {
		this.loperate = loperate;
	}
	public int getLlogin() {
		return llogin;
	}
	public void setLlogin(int llogin) {
		this.llogin = llogin;
	}
	@Override
	public String toString() {
		return "LibUserVO [lid=" + lid + ", lpw=" + lpw + ", lname=" + lname + ", ltel=" + ltel + ", laddr=" + laddr
				+ ", lholiday=" + lholiday + ", loperate=" + loperate + ", llogin=" + llogin + "]";
	}

	
}
