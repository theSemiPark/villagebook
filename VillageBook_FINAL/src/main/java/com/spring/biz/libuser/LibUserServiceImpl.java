package com.spring.biz.libuser;

public class LibUserServiceImpl implements LibUserService{
	private LibUserDAO libuserDAO;
	
	
	public void setLibUserDAO(LibUserDAO libuserDAO) {
		this.libuserDAO = libuserDAO;
	}
	
	public LibUserVO getLibUser(LibUserVO vo) {
		return libuserDAO.getLibUser(vo);
	}
	
	public void insertLibUser(LibUserVO vo) {
		libuserDAO.insertLibUser(vo);
	}

	public void updateLibUser(LibUserVO vo) {
		libuserDAO.updateLibUser(vo);
	}
}
