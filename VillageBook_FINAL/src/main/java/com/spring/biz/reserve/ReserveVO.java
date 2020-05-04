package com.spring.biz.reserve;

public class ReserveVO {
	private long revid;
	private String cid;
	private long isbn;
	private String lid;
	private String lname;
	private int revrank;
	private String bookname; // table에 없음
	
	public long getRevid() {
		return revid;
	}
	public void setRevid(long revid) {
		this.revid = revid;
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
	public int getRevrank() {
		return revrank;
	}
	public void setRevrank(int revrank) {
		this.revrank = revrank;
	}
	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	@Override
	public String toString() {
		return "ReserveVO [revid=" + revid + ", cid=" + cid + ", isbn=" + isbn + ", lid=" + lid + ", revrank=" + revrank
				+ "]";
	}
}
