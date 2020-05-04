package com.spring.biz.mileage;

import java.util.List;

public class MileageServiceImpl implements MileageService{

	private MileageDAO mileageDAO;

	
	public MileageVO getMileage(MileageVO vo) {
		return mileageDAO.getMileage(vo);
	}
	
	public List<MileageVO> getMileageList(MileageVO vo){
		return mileageDAO.getMileageList(vo);
	}
}
