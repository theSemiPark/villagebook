package com.spring.biz.book;

import java.util.List;

public interface BookService {
	void insertBook(BookVO vo);
	void insertRental(BookVO vo);
	void updateBook(BookVO vo);
	void updateRental(BookVO vo);
	void deleteBook(BookVO vo);
	void deleteRental(BookVO vo);
	BookVO getBook(BookVO vo);
	List<BookVO> getBookList(BookVO vo);
	List<BookVO> getLibBookList(BookVO vo);
	List<BookVO> getLibBookList1(BookVO vo);


}
