package com.spring.biz.book;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("bookService")
public class BookServiceImpl implements BookService {

	@Autowired
	private BookDAO bookDAO;

	@Override
	public void insertBook(BookVO vo) {
		// TODO Auto-generated method stub
		bookDAO.insertBook(vo);
	}
	@Override
	public void insertRental(BookVO vo) {
		// TODO Auto-generated method stub
		bookDAO.insertRental(vo);
	}
	@Override
	public void updateBook(BookVO vo) {
		// TODO Auto-generated method stub
		bookDAO.updateBook(vo);
	}
	@Override
	public void updateRental(BookVO vo) {
		// TODO Auto-generated method stub
		bookDAO.updateRental(vo);
	}

	@Override
	public void deleteBook(BookVO vo) {
		// TODO Auto-generated method stub
		bookDAO.deleteBook(vo);
	}
	@Override
	public void deleteRental(BookVO vo) {
		// TODO Auto-generated method stub
		bookDAO.deleteRental(vo);
	}
	@Override
	public BookVO getBook(BookVO vo) {
		return bookDAO.getBook(vo);
	}

	@Override
	public List<BookVO> getBookList(BookVO vo) {
		return bookDAO.getBookList(vo);
	}
	@Override
	public List<BookVO> getLibBookList(BookVO vo) {
		return bookDAO.getLibBookList(vo);
	}
	@Override
	public List<BookVO> getLibBookList1(BookVO vo) {
		return bookDAO.getLibBookList1(vo);
	}


	

}
