package com.spring.biz.point;

public class PointVO {
	private String cid;
	private long ordid;
	private int plusp;
	private int minusp;
	
	
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public long getOrdid() {
		return ordid;
	}
	public void setOrdid(long ordid) {
		this.ordid = ordid;
	}
	public int getPlusp() {
		return plusp;
	}
	public void setPlusp(int plusp) {
		this.plusp = plusp;
	}
	public int getMinusp() {
		return minusp;
	}
	public void setMinusp(int minusp) {
		this.minusp = minusp;
	}
	
	@Override
	public String toString() {
		return "PointVO [cid=" + cid + ", ordid=" + ordid + ", minusp=" + minusp + ", plusp=" + plusp + "]";
	}
}
