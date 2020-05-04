package com.spring.biz.point;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.biz.common.JDBCUtil;

@Repository("pointDAO")
public class PointDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	
	private final String POINT_INSERT = "insert into point values (PID_SEQ.NEXTVAL, ?, ?, ?, ?)";
	private final String UPDATE_POINT = "update user_info set cpoint = cpoint + ? where cid = ?";
	private final String POINT_GET = "select * from point where cid = ? order by pid";
	
	void insertPoint(PointVO vo) {
		System.out.println("===> JDBC로 insertPoint() 기능처리");
		try {
			conn = JDBCUtil.getConnection();
			
			//Point table에 업데이트
			stmt = conn.prepareStatement(POINT_INSERT);
			stmt.setString(1, vo.getCid());
			stmt.setLong(2, vo.getOrdid());
			stmt.setInt(3, vo.getPlusp());
			stmt.setInt(4, vo.getMinusp());
			stmt.executeUpdate();
			
			//사용자 마일리지 수정
			stmt = conn.prepareStatement(UPDATE_POINT);
			stmt.setDouble(1, vo.getPlusp() - vo.getMinusp());
			stmt.setString(2, vo.getCid());
			stmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}
	
	List<PointVO> getPoints(String cid) {
		System.out.println("===> JDBC로 getPoints() 기능처리");
		List<PointVO> pointList = new ArrayList<PointVO>();
		
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(POINT_GET);
			stmt.setString(1, cid);

			rs = stmt.executeQuery();
			while (rs.next()) {
				PointVO point = new PointVO();
				point.setCid(rs.getString("cid"));
				point.setOrdid(rs.getLong("ordid"));
				point.setPlusp(rs.getInt("plusp"));
				point.setMinusp(rs.getInt("minusp"));
				pointList.add(point);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		
		return pointList;
	}
}