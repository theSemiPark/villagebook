package com.spring.biz.mileage;

public class MileageVO {
	private String cid;
	private String cname;
	private int crank;
	private int cpoint;
	
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
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
	public int getCpoint() {
		return cpoint;
	}
	public void setCpoint(int cpoint) {
		this.cpoint = cpoint;
	}
	
	@Override
	public String toString() {
		return "MileageVO [cid=" + cid + ", cname=" + cname + ", crank=" + crank + ", cpoint=" + cpoint + "]";
	}
	
}
