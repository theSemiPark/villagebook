package com.spring.biz.mileage;

import java.util.List;

public interface MileageService {

	MileageVO getMileage(MileageVO vo);
	
	//마일리지를 포함한 회원 목록 조회
	List<MileageVO> getMileageList(MileageVO vo);

}
