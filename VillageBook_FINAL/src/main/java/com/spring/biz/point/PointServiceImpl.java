package com.spring.biz.point;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("pointService")
public class PointServiceImpl implements PointService {
	@Autowired
	private PointDAO pointDAO;
	
	public void insertPoint(PointVO vo) {
		pointDAO.insertPoint(vo);
	}
	
	public List<PointVO> getPoints(String cid){
		return pointDAO.getPoints(cid);
	}
}