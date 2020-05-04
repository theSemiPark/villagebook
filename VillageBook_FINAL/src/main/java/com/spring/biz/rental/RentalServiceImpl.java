package com.spring.biz.rental;

import java.util.List;

public class RentalServiceImpl {
	
	private RentalDAO rentalDAO;
	
	
	public List<RentalVO> getRentalList(RentalVO vo){
		return rentalDAO.getRentalList(vo);
	}

	public List<RentalVO> getRentalStatus(RentalVO vo2){
		return rentalDAO.getRentalStatus(vo2);
	}

}
