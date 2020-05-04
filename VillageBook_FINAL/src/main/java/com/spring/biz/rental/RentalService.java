package com.spring.biz.rental;

import java.util.List;

public interface RentalService {
	
	List<RentalVO> getRentalList(RentalVO vo);
	
	List<RentalVO> getRentalStatus(RentalVO vo2);
	
}
