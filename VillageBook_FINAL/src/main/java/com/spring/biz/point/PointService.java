package com.spring.biz.point;

import java.util.List;

public interface PointService {
	void insertPoint(PointVO vo);
	List<PointVO> getPoints(String cid);
}
