package com.spring.biz.libinfo;

public class LibInfoVO {
	private String lid;
	private String lname;
	private String ltel;
	private String laddr;
	private String lholiday;
	private String loperate;
	
	public String getLid() {
		return lid;
	}
	public void setLid(String lid) {
		this.lid = lid;
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
	@Override
	public String toString() {
		return "LibInfoVO [lid=" + lid + ", lname=" + lname + ", ltel=" + ltel + ", laddr=" + laddr + ", lholiday="
				+ lholiday + ", loperate=" + loperate + "]";
	}
	
	

}
