package com.spring.biz.reserve;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("reserveService")
public class ReserveServiceImpl implements ReserveService{
	
	@Autowired
	private ReserveDAO reserveDAO;
	
	public char insertReserve(ReserveVO vo) {
		return reserveDAO.insertReserve(vo);
	}
	
	public List<ReserveVO> getReserveList_lib(ReserveVO vo){
		return reserveDAO.getReserveList_lib(vo);
	}

	public void deleteReserve(ReserveVO vo) {
		reserveDAO.deleteReserve(vo);
	}

	public List<ReserveVO> getReserveList(ReserveVO vo) {
		return reserveDAO.getReserveList(vo);
	}
}
