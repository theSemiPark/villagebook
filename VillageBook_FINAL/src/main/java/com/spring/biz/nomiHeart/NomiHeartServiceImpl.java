package com.spring.biz.nomiHeart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("nomiHeartService")
public class NomiHeartServiceImpl implements NomiHeartService {

	@Autowired
	private NomiHeartDAO nomiHeartDAO;
	
	@Override
	public void insertNomiHeart(NomiHeartVO vo) {
		nomiHeartDAO.insertNomiHeart(vo);
	}

	@Override
	public void deleteNomiHeart(NomiHeartVO vo) {
		nomiHeartDAO.deleteNomiHeart(vo);
	}
}
