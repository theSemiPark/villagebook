package com.spring.biz.libinfo;

public class LibInfoServiceImpl implements LibInfoService {

	private LibInfoDAO libinfoDAO;

	public LibInfoVO getLibInfoList(LibInfoVO vo) {
		return libinfoDAO.getLibInfoList(vo);
	}

}
