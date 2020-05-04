package com.spring.biz.reserve;

import java.util.List;

public interface ReserveService {

	char insertReserve(ReserveVO vo);
	List<ReserveVO> getReserveList_lib(ReserveVO vo);
	void deleteReserve(ReserveVO vo);
	List<ReserveVO> getReserveList(ReserveVO vo);

}
