package com.spring.biz.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.spring.biz.common.JDBCUtil;

//DAO(Data Access Object)
public class UserDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;

	private final String USER_GET = "select * from user_info where cid=? and cpw=?";
	private final String USER_GET2 = "select * from user_info where cid=?";
	private final String USER_INSERT = "insert into user_info(cid, cpw, cname, crank, chp, cpostcode, caddr1, caddr2, cpoint, careaid)"
			+ "values(?, ?, ?, 1, ?, ?, ?, ?,10000, 9)";
	private final String USER_AREAID = "update user_info set careaid= (select id from area where area.gu = (SELECT REGEXP_SUBSTR (caddr1,'[^ ]+', 1, 2) FROM USER_INFO WHERE CID = ?)) where cid=?";
	private final String USER_UPDATE = "update user_info set cname=?, cpw=?, chp=?, cpostcode=?, caddr1=?, caddr2=? where cid=?";
	private final String OVER_CHECK = "select * from user_info where cid = ?";

	private final String JOIN_POINT = "insert into point values (pid_seq.nextval, ?, 0, 10000, 0)";

	private final String LOGIN = "update user_info set clogin = 1 where cid = ?";
	private final String LOGOUT = "update user_info set clogin = 0 where cid = ?";

	private final String RANK_GET = "select user_info.*, nvl(ordmoney30, 0) ordmoney30 from user_info, (select cid, sum(ordmoney) ordmoney30 from (select distinct ordid, cid, ordmoney from delivery where trunc(orderdate) > trunc(sysdate)-30) group by cid) a where a.cid(+) = user_info.cid";

	private final String CPOINT_UPDATE = "update user_info set cpoint=? where cid = ?";
	private final String POINT_INSERT = "insert into point values (pid_seq.nextval, ?, 3, ?, ?)";
	private final String POINT_INFO = "select cname from user_info where cid=?";

	private final String RANK_SET = "update user_info set crank = ? where cid = ?";
	private final String MSG_RANK = "INSERT INTO MESSAGE VALUES (M_SEQ.NEXTVAL, ?, 'server', ?, NULL, SYSDATE)";

	public UserVO getUser(UserVO vo) {
		UserVO user = null;
		try {
			System.out.println("===> JDBC로 getUser() 기능 처리");
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_GET);
			stmt.setString(1, vo.getCid());
			stmt.setString(2, vo.getCpw());
			rs = stmt.executeQuery();
			if (rs.next()) {
				user = new UserVO();
				user.setCid(rs.getString("CID"));
				user.setCpw(rs.getString("CPW"));
				user.setCname(rs.getString("CNAME"));
				user.setCrank(rs.getInt("CRANK"));
				user.setChp(rs.getString("CHP"));
				user.setCpostcode(rs.getString("CPOSTCODE"));
				user.setCaddr1(rs.getString("CADDR1"));
				user.setCaddr2(rs.getString("CADDR2"));
				user.setCpoint(rs.getInt("CPOINT"));
				user.setCareaid(rs.getInt("CAREAID"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}

		return user;
	}

	public UserVO getUserInfo(UserVO vo) {
		UserVO user = null;

		try {
			System.out.println("===> JDBC로 getUserInfo() 기능 처리");
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_GET2);
			stmt.setString(1, vo.getCid());
			rs = stmt.executeQuery();
			if (rs.next()) {
				user = new UserVO();
				user.setCid(rs.getString("CID"));
				user.setCpw(rs.getString("CPW"));
				user.setCname(rs.getString("CNAME"));
				user.setCrank(rs.getInt("CRANK"));
				user.setChp(rs.getString("CHP"));
				user.setCpostcode(rs.getString("CPOSTCODE"));
				user.setCaddr1(rs.getString("CADDR1"));
				user.setCaddr2(rs.getString("CADDR2"));
				user.setCpoint(rs.getInt("CPOINT"));
				user.setCareaid(rs.getInt("CAREAID"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}

		return user;
	}

	public void insertUser(UserVO vo) {
		System.out.println("===> JDBC로 insertUser() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_INSERT);
			stmt.setString(1, vo.getCid());
			stmt.setString(2, vo.getCpw());
			stmt.setString(3, vo.getCname());
			stmt.setString(4, vo.getChp());
			stmt.setString(5, vo.getCpostcode());
			stmt.setString(6, vo.getCaddr1());
			stmt.setString(7, vo.getCaddr2());
			stmt.executeUpdate();

			stmt = conn.prepareStatement(JOIN_POINT);
			stmt.setString(1, vo.getCid());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public void insertAreaid(UserVO vo) {
		System.out.println("===> 사용자 구역 할당");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_AREAID);
			stmt.setString(1, vo.getCid());
			stmt.setString(2, vo.getCid());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}

	}

	public void updateUser(UserVO vo) {
		System.out.println("===> JDBC로 updateBoard() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_UPDATE);
			stmt.setString(1, vo.getCname());
			stmt.setString(2, vo.getCpw());
			stmt.setString(3, vo.getChp());
			stmt.setString(4, vo.getCpostcode());
			stmt.setString(5, vo.getCaddr1());
			stmt.setString(6, vo.getCaddr2());
			stmt.setString(7, vo.getCid());
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public boolean overCheck(String cid) {
		System.out.println("===> JDBC로 overCheck() 기능 처리");
		boolean result = false;
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(OVER_CHECK);
			stmt.setString(1, cid);
			rs = stmt.executeQuery();

			if (rs.next())
				result = true;
			else
				result = false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
		return result;
	}

	public void logout(String id) {
		System.out.println("===> JDBC로 logout() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(LOGOUT);
			stmt.setString(1, id);
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public void login(String id) {
		System.out.println("===> JDBC로 login() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(LOGIN);
			stmt.setString(1, id);
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public List<UserVO> getRankList() {
		System.out.println("===> JDBC로 getRankList() 기능 처리");
		List<UserVO> rankList = new ArrayList<UserVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(RANK_GET);
			rs = stmt.executeQuery();

			while (rs.next()) {
				UserVO rank = new UserVO();
				rank.setCid(rs.getString("cid"));
				rank.setCname(rs.getString("cname"));
				rank.setCaddr1(rs.getString("caddr1"));
				rank.setCaddr2(rs.getString("caddr2"));
				rank.setCpostcode(rs.getString("cpostcode"));
				rank.setCareaid(rs.getInt("careaid"));
				rank.setChp(rs.getString("chp"));
				rank.setCrank(rs.getInt("crank"));
				rank.setCpoint(rs.getInt("cpoint"));
				rank.setOrdmoney30(rs.getInt("ordmoney30"));
				rankList.add(rank);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
		return rankList;
	}

	// 포인트 업데이트
	public void updatePoint(UserVO vo, int old) {
		System.out.println("==>point 업데이트");
		try {
			conn = JDBCUtil.getConnection();

			if (vo.getCpoint() != old) {
				stmt = conn.prepareStatement(POINT_INSERT);
				stmt.setString(1, vo.getCid());
				if (old > vo.getCpoint()) {
					stmt.setInt(2, 0);
					stmt.setInt(3, old - vo.getCpoint());
				} else {
					stmt.setInt(2, vo.getCpoint() - old);
					stmt.setInt(3, 0);
				}
				stmt.executeUpdate();

				stmt = conn.prepareStatement(CPOINT_UPDATE);
				stmt.setInt(1, vo.getCpoint());
				stmt.setString(2, vo.getCid());
				stmt.executeQuery();
			}

			stmt = conn.prepareStatement(POINT_INFO);
			stmt.setString(1, vo.getCid());
			stmt.executeUpdate();
			System.out.println(vo.getCpoint());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

	public void rankUpdate(UserVO vo, int oldRank) {
		System.out.println("===> JDBC로 rankUpdate() 기능 처리");
		try {
			conn = JDBCUtil.getConnection();

			if (vo.getCrank() != oldRank) {
				stmt = conn.prepareStatement(RANK_SET);
				stmt.setInt(1, vo.getCrank());
				stmt.setString(2, vo.getCid());
				stmt.executeUpdate();

				stmt = conn.prepareStatement(MSG_RANK);
				stmt.setString(1, vo.getCid());
				if (vo.getCrank() == 0) {
					stmt.setString(2, "블랙리스트에 등재되셨습니다. 이후 서비스 이용이 불가능합니다.");
				} else if (oldRank == 0) {
					stmt.setString(2, "블랙리스트에서 해제되셨으며, "+vo.getCrank()+"등급으로 변경되셨습니다.");
				} else {
					stmt.setString(2, oldRank+"등급에서 "+vo.getCrank()+"등급으로 변경되셨습니다.");
				}
				stmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(stmt, conn);
		}
	}

}
