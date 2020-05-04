package com.spring.biz.libinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.spring.biz.common.JDBCUtil;

//@Repository("libinfoDAO")
public class LibInfoDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;

	private final String GET_LIBINFO = "select * from library where lid = ?";
	private final String GET_LIBLIST = "select * from library where lid != 'admin' order by lname";
	private final String LIB_MODIFY = "update library set lname = ?, ltel = ?, laddr = ?, lholiday = ?, loperate = ? where lid = ?";
	
	public LibInfoVO getLibInfoList(LibInfoVO vo) {
		System.out.println("===>JDBC로 getLibInfoList() 기능 처리");
		LibInfoVO libinfo = new LibInfoVO();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(GET_LIBINFO);
			stmt.setString(1, vo.getLid());
			rs = stmt.executeQuery();
			if(rs.next()) {
				libinfo.setLid(rs.getString("LID"));
				libinfo.setLname(rs.getString("LNAME"));
				libinfo.setLtel(rs.getString("LTEL"));
				libinfo.setLaddr(rs.getString("LADDR"));
				libinfo.setLholiday(rs.getString("LHOLIDAY"));
				libinfo.setLoperate(rs.getString("LOPERATE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return libinfo;
	}
	
	public List<LibInfoVO> getLibList_admin(){
		List<LibInfoVO> libList = new ArrayList<LibInfoVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(GET_LIBLIST);
			rs = stmt.executeQuery();
			while(rs.next()) {
				LibInfoVO lib = new LibInfoVO();
				lib.setLid(rs.getString("LID"));
				lib.setLname(rs.getString("LNAME"));
				lib.setLtel(rs.getString("LTEL"));
				lib.setLaddr(rs.getString("LADDR"));
				lib.setLholiday(rs.getString("LHOLIDAY"));
				lib.setLoperate(rs.getString("LOPERATE"));
				libList.add(lib);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return libList;
	}

	public void libInfoModify(LibInfoVO vo) {
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(LIB_MODIFY);
			stmt.setString(1, vo.getLname());
			stmt.setString(2, vo.getLtel());
			stmt.setString(3, vo.getLaddr());
			stmt.setString(4, vo.getLholiday());
			stmt.setString(5, vo.getLoperate());
			stmt.setString(6, vo.getLid());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		
	}
}