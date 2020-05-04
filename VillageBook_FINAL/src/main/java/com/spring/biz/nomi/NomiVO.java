package com.spring.biz.nomi;

import java.sql.Date;

//VO(Value Object)
public class NomiVO {
	private int seq;
	private String title;	
	private String writer;
	private String content;
	private Integer rating;
	private Date regDate;
	private int cnt;
	private String searchCondition;
	private String searchKeyword;
	private boolean didIHeart;
	private int howManyHeart;
	
	public boolean isDidIHeart() {
		return didIHeart;
	}

	public void setDidIHeart(boolean didIHeart) {
		this.didIHeart = didIHeart;
	}

	public int getHowManyHeart() {
		return howManyHeart;
	}

	public void setHowManyHeart(int howManyHeart) {
		this.howManyHeart = howManyHeart;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
		this.rating = rating;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
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
		return "NomiVO [seq=" + seq + ", title=" + title + ", content=" + content + ", regDate="
				+ regDate + ", cnt=" + cnt + "]";
	}

}
