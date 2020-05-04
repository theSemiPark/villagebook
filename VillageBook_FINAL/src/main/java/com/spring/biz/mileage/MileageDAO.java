package com.spring.biz.mileage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import com.spring.biz.common.JDBCUtil;

//@Repository("mileageDAO")
public class MileageDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	
	//회원정보(아이디, 이름, 등급, 마일리지)를 불러오는 SQL문
	private final String MEMINFO_GET = "select cid, cname, crank, cpoint from user_info";
	private final String MEMINFO_LIST = "select * from user_info order by crank";
	
	//회원 정보 불러오기
	public MileageVO getMileage(MileageVO vo){
		System.out.println("===> JDBC로 getMemInfo() 기능처리");
		MileageVO mileage = null;
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(MEMINFO_GET);
			stmt.setString(1, vo.getCid());
			rs = stmt.executeQuery();
			if(rs.next()) {
				mileage = new MileageVO();
				mileage.setCid(rs.getString("CID"));
				mileage.setCname(rs.getString("CNAME"));
				mileage.setCrank(rs.getInt("CRANK"));
				mileage.setCpoint(rs.getInt("CPOINT"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return mileage;
	}
	
	public List<MileageVO> getMileageList(MileageVO vo){
		System.out.println("===> JDBC로 getMileageList() 기능처리");
		List<MileageVO> mileageList = new ArrayList<MileageVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(MEMINFO_LIST);
			rs = stmt.executeQuery();
			while(rs.next()) {
				MileageVO mileage = new MileageVO();
				mileage = new MileageVO();
				mileage.setCid(rs.getString("CID"));
				mileage.setCname(rs.getString("CNAME"));
				mileage.setCrank(rs.getInt("CRANK"));
				mileage.setCpoint(rs.getInt("CPOINT"));
				mileageList.add(mileage);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return mileageList;
	}

}
