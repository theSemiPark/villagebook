package com.spring.biz.book;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class BookVO {
	private int rcnt;
	private int havecnt;
	private String lid;
	private long isbn;
	private String bookname;
	private String author;
	private String publisher;
	private Date pdate;
	private String genre;
	private String searchCondition;
	private String searchKeyword;
	private String img;
	private MultipartFile uploadFile;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	
	public long getIsbn() {
		return isbn;
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
	public String getLid() {
		return lid;
	}
	public void setLid(String lid) {
		this.lid = lid;
	}
	public void setIsbn(long isbn) {
		this.isbn = isbn;
	}
	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
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
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	@Override
	public String toString() {
		return "BookVO [rcnt=" + rcnt + ", havecnt=" + havecnt + ", lid=" + lid + ", isbn=" + isbn + ", bookname="
				+ bookname + ", author=" + author + ", publisher=" + publisher + ", pdate=" + pdate + ", genre=" + genre
				+ ", searchCondition=" + searchCondition + ", searchKeyword=" + searchKeyword + ", img=" + img + "]";
	}	
}
