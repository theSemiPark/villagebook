
package com.spring.biz.delivery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import com.spring.biz.cart.StockVO;
import com.spring.biz.common.JDBCUtil;
import com.spring.biz.user.UserVO;

public class DeliveryDAO {

	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;

	private final String ORDID_LIST = "select distinct ordid, orderdate, startdate from delivery where cid=? and ( returnwer='N' or returnwer='R' ) order by ordid";
	private final String ORDID_HISTORY_LIST = "select distinct ordid, orderdate, startdate from delivery where cid=? and returnwer='Y' order by ordid";
	private final String ORD_LIST = "select delivery.*, library.lname from delivery, library where ordid= ? and delivery.lid = library.lid and (returnwer='N' or returnwer='R') order by library.lid";
	private final String ORD_HISTORY_LIST = "select delivery.*, library.lname from delivery, library where ordid= ? and delivery.lid = library.lid and returnwer='Y' order by library.lid";

	private final String BOARD_INSERT = "insert into delivery values (?, ?, ?, ?, ?, ?, ?, ? + 4/24, ? + 14, 0, 'N', 'N', ?)";
	private final String BOARD_INSERT2 = "insert into delivery values (?, ?, ?, ?, ?, ?, ?, ? + 4/24, ? + 14, 0, 'N', 'N', ?)";

	private final String ALL_ORDER = "select distinct ordid, orderdate, ordmoney, cid, max(shipping) smax, count(distinct shipping) scnt, max(returnwer) rmax, count(distinct returnwer) rcnt from delivery group by ordid, orderdate, ordmoney, cid order by ordid desc";
	private final String ORDER_LIB = "select distinct ordid, delivery.lid, lname, startdate, returndate, shipping, renewtf, returnwer from delivery, library where ordid = ? and delivery.lid = library.lid order by delivery.lid";
	private final String LIB_BOOK = "select bookname, isbn, ordercnt from delivery where ordid = ? and lid = ? order by bookname";

	private final String DELI_SELECT = "select * from delivery where ordid = ? and returnwer != 'Y'";
	private final String DELI_RCNT = "update rental set rcnt = rcnt - ? where isbn = ? and lid = ?";
	private final String DELI_CANCEL = "update delivery set shipping = 5, returnwer = 'Y' where ordid = ?";

	private final String SEARCH_POINT = "select * from point where ordid = ?";
	private final String INSERT_POINT = "insert into point values (pid_seq.nextval, ?, 1, ?, ?)";
	private final String UPDATE_USER = "update user_info set cpoint = cpoint + ? where cid = ?";

	private final String DELETE_PAST = "delete from delivery where orderdate < ? and returnwer = 'Y'";
	private final String DELILIST_LIB = "select distinct ordid, orderdate, shipping, cid from delivery where lid = ? and shipping < 2 order by ordid";
	private final String DELIDEAIL_LIB = "select * from delivery where lid = ? and ordid = ?";
	private final String USER_INFO_GET = "select * from user_info where cid = ?";
	private final String LIB_UPDATE_SHIP = "update delivery set shipping = shipping + 1 where ordid = ? and lid = ?";
	
	private final String GET_DELIVERY_ADMIN = "select distinct ordid, cid, orderdate, max(shipping) smax, count(distinct shipping) scnt, max(returnwer) rmax, count(distinct returnwer) rcnt from delivery";
	private final String GET_DELIVERY_ADMINMAIN = "select distinct ordid, cid, orderdate, returndate, ordmoney, lname from delivery, library where delivery.lid = library.lid";

	private final String ORDER_INFO = "select distinct cid, orderdate, ordmoney from delivery where ordid = ?";
	private final String MSG_CANCEL = "INSERT INTO MESSAGE VALUES (M_SEQ.NEXTVAL, ?, 'server', ?, NULL, SYSDATE)";

	public long insertDelivery(DeliveryListVO list, int sum, int usepoint) {
		System.out.println("===> JDBC insertDelivery()");
		String cid = null;
		long ordid = 0;
		try {
			// delivery table에 인서트
			List<DeliveryVO> listvo = list.getList();
			java.util.Date utilDate = new java.util.Date();
			SimpleDateFormat transFormat1 = new SimpleDateFormat("yyyyMMddHHmmss");
			ordid = Long.parseLong(transFormat1.format(utilDate));
			Timestamp now = new Timestamp(utilDate.getTime());
			
			for (int i = 0; i < listvo.size(); i++) {
				DeliveryVO vo = listvo.get(i);
				System.out.println(vo);
				conn = JDBCUtil.getConnection();
				if (i == 0) {
					System.out.println(vo.getLid());
					stmt = conn.prepareStatement(BOARD_INSERT);
					stmt.setLong(1, ordid);
					stmt.setLong(2, vo.getIsbn());
					stmt.setString(3, vo.getCid());
					stmt.setString(4, vo.getLid());
					stmt.setLong(5, vo.getOrdercnt());
					stmt.setLong(6, sum);
					stmt.setTimestamp(7, now);
					stmt.setTimestamp(8, now);
					stmt.setTimestamp(9, now);
					stmt.setString(10, vo.getBookname());
				} else {
					System.out.println(vo.getLid());
					stmt = conn.prepareStatement(BOARD_INSERT2);
					stmt.setLong(1, ordid);
					stmt.setLong(2, vo.getIsbn());
					stmt.setString(3, vo.getCid());
					stmt.setString(4, vo.getLid());
					stmt.setLong(5, vo.getOrdercnt());
					stmt.setLong(6, sum);
					stmt.setTimestamp(7, now);
					stmt.setTimestamp(8, now);
					stmt.setTimestamp(9, now);
					stmt.setString(10, vo.getBookname());
				}

				stmt.executeUpdate();

				// reserve 통해 대여하는지 확인
				stmt = conn.prepareStatement("select * from rental where rcnt = havecnt and lid = ? and isbn = ?");
				stmt.setString(1, vo.getLid());
				stmt.setLong(2, vo.getIsbn());
				rs = stmt.executeQuery();
				if(rs.next()) {
					// reserve 통한 경우 본인 컬럼 삭제
					stmt = conn.prepareStatement("delete from reserve where lid = ? and isbn = ? and cid = ?");
					stmt.setString(1, vo.getLid());
					stmt.setLong(2, vo.getIsbn());
					stmt.setString(3, vo.getCid());
					stmt.executeUpdate();
					
					// 같은 책 예약한 사람들 예약순위 업데이트
					stmt = conn.prepareStatement("update reserve set revrank = revrank - 1 where lid = ? and isbn = ?");
					stmt.setString(1, vo.getLid());
					stmt.setLong(2, vo.getIsbn());
					stmt.executeUpdate();

				} else {
				// reserve 아닌 경우 rental table에서 대여권수 업데이트
					stmt = conn.prepareStatement("update rental set rcnt = rcnt + ? where lid = ? and isbn = ?");
					stmt.setLong(1, vo.getOrdercnt());
					stmt.setString(2, vo.getLid());
					stmt.setLong(3, vo.getIsbn());
					stmt.executeUpdate();
				}
				cid = vo.getCid();
			}
			// 카트 리셋
			stmt = conn.prepareStatement("delete from cart where cid = ?");
			stmt.setString(1, cid);
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return ordid;
	}

	public List<DeliveryVO> getOrdidList(DeliveryVO vo) {
		System.out.println("===> JDBC getOrdidList()");
		List<DeliveryVO> boardList = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(ORDID_LIST);
			System.out.println("cid : " + vo.getCid());
			stmt.setString(1, vo.getCid());
			rs = stmt.executeQuery();
			while (rs.next()) {
				DeliveryVO board = new DeliveryVO();
				board.setOrdid(rs.getLong(1));
				board.setOrderdate(rs.getDate(2));
				board.setStartdate(rs.getDate(3));
				boardList.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return boardList;
	}
	
	public List<DeliveryVO> getOrdidHistoryList(DeliveryVO vo) {
		System.out.println("===> JDBC getHistoryList()");
		List<DeliveryVO> boardList = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(ORDID_HISTORY_LIST);
			System.out.println("cid : " + vo.getCid());
			stmt.setString(1, vo.getCid());
			rs = stmt.executeQuery();
			while (rs.next()) {
				DeliveryVO board = new DeliveryVO();
				board.setOrdid(rs.getLong(1));
				board.setOrderdate(rs.getDate(2));
				board.setStartdate(rs.getDate(3));
				boardList.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return boardList;
	}

	public List<DeliveryVO> getOrdList(DeliveryVO vo) {
		System.out.println("===> JDBC getOrdList()");
		List<DeliveryVO> boardList = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(ORD_LIST);
			stmt.setLong(1, vo.getOrdid());
			rs = stmt.executeQuery();
			while (rs.next()) {
				System.out.println(rs.getString("lid"));
				DeliveryVO board = new DeliveryVO();
				board.setOrdid(rs.getLong("ordid"));
				board.setIsbn(rs.getLong("isbn"));
				board.setCid(rs.getString("cid"));
				board.setLid(rs.getString("lid"));
				board.setOrdercnt(rs.getLong("ordercnt"));
				board.setOrdmoney(rs.getLong("ordmoney"));
				board.setOrderdate(rs.getDate("orderdate"));
				board.setStartdate(rs.getDate("startdate"));
				board.setReturndate(rs.getDate("returndate"));
				board.setShipping(rs.getLong("shipping"));
				board.setRenewtf(rs.getString("renewtf"));
				board.setReturnwer(rs.getString("returnwer"));
				board.setBookname(rs.getString("bookname"));
				board.setLname(rs.getString("lname"));
				boardList.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return boardList;
	}
	
	public List<DeliveryVO> getOrdHistoryList(DeliveryVO vo) {
		System.out.println("===> JDBC getOrdHistoryList()");
		List<DeliveryVO> boardList = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(ORD_HISTORY_LIST);
			stmt.setLong(1, vo.getOrdid());
			rs = stmt.executeQuery();
			while (rs.next()) {
				System.out.println(rs.getString("lid"));
				DeliveryVO board = new DeliveryVO();
				board.setOrdid(rs.getLong("ordid"));
				board.setIsbn(rs.getLong("isbn"));
				board.setCid(rs.getString("cid"));
				board.setLid(rs.getString("lid"));
				board.setOrdercnt(rs.getLong("ordercnt"));
				board.setOrdmoney(rs.getLong("ordmoney"));
				board.setOrderdate(rs.getDate("orderdate"));
				board.setStartdate(rs.getDate("startdate"));
				board.setReturndate(rs.getDate("returndate"));
				board.setShipping(rs.getLong("shipping"));
				board.setRenewtf(rs.getString("renewtf"));
				board.setReturnwer(rs.getString("returnwer"));
				board.setBookname(rs.getString("bookname"));
				board.setLname(rs.getString("lname"));
				boardList.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return boardList;
	}

	public List<DeliveryVO> getOrder_admin() {
		System.out.println("===> JDBC getOrder_admin()");
		List<DeliveryVO> deliveryList = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(ALL_ORDER);
			rs = stmt.executeQuery();
			while (rs.next()) {
				DeliveryVO delivery = new DeliveryVO();
				delivery.setOrdid(rs.getLong("ordid"));
				delivery.setOrderdate(rs.getDate("orderdate"));
				delivery.setOrdmoney(rs.getLong("ordmoney"));
				delivery.setCid(rs.getString("cid"));
				delivery.setShipping(rs.getInt("smax"));
				delivery.setShipcnt(rs.getInt("scnt"));
				delivery.setReturnwer(rs.getString("rmax"));
				delivery.setRetcnt(rs.getInt("rcnt"));
				deliveryList.add(delivery);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return deliveryList;
	}

	public List<DeliveryVO> getOrderLib_admin(DeliveryVO vo) {
		System.out.println("===> JDBC getOrderLib_admin()");
		List<DeliveryVO> deliveryList = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(ORDER_LIB);

			stmt.setLong(1, vo.getOrdid());
			rs = stmt.executeQuery();
			while (rs.next()) {
				DeliveryVO delivery = new DeliveryVO();
				delivery.setOrdid(rs.getLong("ordid"));
				delivery.setLname(rs.getString("lname"));
				delivery.setLid(rs.getString("lid"));
				delivery.setStartdate(rs.getDate("startdate"));
				delivery.setReturndate(rs.getDate("returndate"));
				delivery.setShipping(rs.getInt("shipping"));
				delivery.setRenewtf(rs.getString("renewtf"));
				delivery.setReturnwer(rs.getString("returnwer"));
				deliveryList.add(delivery);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return deliveryList;
	}

	public List<DeliveryVO> getOrderLibBook_admin(DeliveryVO vo) {
		System.out.println("===> JDBC getOrderLibBook_admin()");
		List<DeliveryVO> deliveryList = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(LIB_BOOK);
			stmt.setLong(1, vo.getOrdid());
			stmt.setString(2, vo.getLid());
			rs = stmt.executeQuery();
			while (rs.next()) {
				DeliveryVO delivery = new DeliveryVO();
				delivery.setBookname(rs.getString("bookname"));
				delivery.setIsbn(rs.getLong("ISBN"));
				delivery.setOrdercnt(rs.getInt("ordercnt"));
				deliveryList.add(delivery);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return deliveryList;
	}

	public void delivery_cancel(DeliveryVO vo) {
		System.out.println("===> JDBC delivery_cancel()");
		try {
			conn = JDBCUtil.getConnection();
			// rental table rollback
			stmt = conn.prepareStatement(DELI_SELECT);
			stmt.setLong(1, vo.getOrdid());
			rs = stmt.executeQuery();
			List<StockVO> check = new ArrayList<StockVO>();
			while (rs.next()) {
				StockVO a = new StockVO();
				a.setIsbn(rs.getLong("isbn"));
				a.setLid(rs.getString("lid"));
				a.setCnt(rs.getInt("ordercnt"));
				check.add(a);
			}
			for (StockVO a : check) {
				stmt = conn.prepareStatement(DELI_RCNT);
				stmt.setInt(1, a.getCnt());
				stmt.setLong(2, a.getIsbn());
				stmt.setString(3, a.getLid());
				stmt.executeUpdate();
			}

			// delivery table update
			stmt = conn.prepareStatement(DELI_CANCEL);
			stmt.setLong(1, vo.getOrdid());
			stmt.executeUpdate();
			// point table update
			stmt = conn.prepareStatement(SEARCH_POINT);
			stmt.setLong(1, vo.getOrdid());
			rs = stmt.executeQuery();
			if (rs.next()) {
				int plusp = rs.getInt("plusp");
				int minusp = rs.getInt("minusp");

				stmt = conn.prepareStatement(INSERT_POINT);
				stmt.setString(1, vo.getCid());
				stmt.setInt(2, minusp);
				stmt.setInt(3, plusp);
				stmt.executeUpdate();

				// user_info table update

				stmt = conn.prepareStatement(UPDATE_USER);
				stmt.setInt(1, minusp - plusp);
				stmt.setString(2, vo.getCid());
				stmt.executeUpdate();
			}
			// 자동메시지
			stmt = conn.prepareStatement(MSG_CANCEL);
			stmt.setString(1, vo.getCid());
			stmt.setString(2, "주문번호 "+vo.getOrdid()+"의 주문이 취소되었습니다.");
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}

	public void delete_past(Date input) {
		System.out.println("===> JDBC delete_past()");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(DELETE_PAST);
			stmt.setDate(1, input);
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}

	public List<DeliveryVO> getLibDeliveryList(String lid) {
		System.out.println("===> JDBC getLibDeliveryList()");
		List<DeliveryVO> deliList = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(DELILIST_LIB);
			stmt.setString(1, lid);
			rs = stmt.executeQuery();

			while (rs.next()) {
				DeliveryVO deli = new DeliveryVO();
				deli.setOrdid(rs.getLong("ordid"));
				deli.setOrderdate(rs.getDate("orderdate"));
				deli.setShipping(rs.getInt("shipping"));
				deli.setCid(rs.getString("cid"));
				deliList.add(deli);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return deliList;
	}

	public List<DeliveryVO> getLibDeliDetail(DeliveryVO vo) {
		System.out.println("===> JDBC getLibDeliDetail()");
		List<DeliveryVO> detailList = new ArrayList<DeliveryVO>();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(DELIDEAIL_LIB);
			stmt.setString(1, vo.getLid());
			stmt.setLong(2, vo.getOrdid());
			rs = stmt.executeQuery();

			while (rs.next()) {
				DeliveryVO deli = new DeliveryVO();
				deli.setBookname(rs.getString("bookname"));
				deli.setIsbn(rs.getLong("isbn"));
				deli.setOrdercnt(rs.getInt("ordercnt"));
				deli.setCid(rs.getString("cid"));
				detailList.add(deli);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return detailList;
	}

	public UserVO getUserInfo(String cid) {
		System.out.println("===> JDBC getUserInfo()");
		UserVO user = new UserVO();
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(USER_INFO_GET);
			stmt.setString(1, cid);
			rs = stmt.executeQuery();

			if (rs.next()) {
				user.setCaddr1(rs.getString("caddr1"));
				user.setCaddr2(rs.getString("caddr2"));
				user.setCpostcode(rs.getString("cpostcode"));
				user.setChp(rs.getString("chp"));
				user.setCname(rs.getString("cname"));
				user.setCid(rs.getString("cid"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return user;
	}

	public void libShipUpdate(DeliveryVO vo) {
		System.out.println("===> JDBC libShipUpdate()");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(LIB_UPDATE_SHIP);
			stmt.setLong(1, vo.getOrdid());
			stmt.setString(2, vo.getLid());
			stmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
	}

	public List<DeliveryVO> getDelivery_admin(DeliveryVO vo) {
		List<DeliveryVO> deliList = new ArrayList<DeliveryVO>();
		int con = 0;
		String ps = GET_DELIVERY_ADMIN;
		try {
			conn = JDBCUtil.getConnection();
			if(vo.getOrderdate() != null) {
				if(con == 0) ps += " where";
				else ps += " and";
				con++;
				ps += " trunc(orderdate) >= '" + vo.getOrderdate() + "'";
			}
			if(vo.getShipping() != 0) {
				if(con == 0) ps += " where";
				else ps += " and";
				con++;
				if(vo.getShipping() == -1) ps += " shipping = 0";
				else ps += " shipping = " + vo.getShipping();
			}
			if(vo.getReturnwer() != null && vo.getReturnwer() != "") {
				if(con == 0) ps += " where";
				else ps += " and";
				con++;
				ps += " returnwer = '" + vo.getReturnwer() + "'";
			}
			ps += " group by ordid, cid, orderdate order by ordid desc";
			System.out.println(ps);
			
			stmt = conn.prepareStatement(ps);
			rs = stmt.executeQuery();
			while (rs.next()) {
				DeliveryVO deli = new DeliveryVO();
				deli.setOrdid(rs.getLong("ordid"));
				deli.setOrderdate(rs.getDate("orderdate"));
				deli.setCid(rs.getString("cid"));
				deli.setShipping(rs.getLong("smax"));
				deli.setShipcnt(rs.getInt("scnt"));
				deli.setReturnwer(rs.getString("rmax"));
				deli.setRetcnt(rs.getInt("rcnt"));
				deliList.add(deli);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return deliList;
	}
	
	public List<DeliveryVO> getDelivery_adminMain(DeliveryVO vo) {
		List<DeliveryVO> deliList = new ArrayList<DeliveryVO>();
		String ps = GET_DELIVERY_ADMINMAIN;
		try {
			conn = JDBCUtil.getConnection();
			if(vo.getShipping() != 0) {
				ps += " and";
				if(vo.getShipping() == -1) ps += " shipping = 0";
				else ps += " shipping = " + vo.getShipping();
			}
			if(vo.getReturnwer() != null && vo.getReturnwer() != "") {
				ps += " and returnwer = '" + vo.getReturnwer() + "'";
			}
			ps += " order by ordid desc";
			ps = "select * from (" + ps + ") where rownum <= 10";
			System.out.println(ps);
			
			stmt = conn.prepareStatement(ps);
			rs = stmt.executeQuery();
			while (rs.next()) {
				DeliveryVO deli = new DeliveryVO();
				deli.setOrdid(rs.getLong("ordid"));
				deli.setOrderdate(rs.getDate("orderdate"));
				deli.setCid(rs.getString("cid"));
				deli.setReturndate(rs.getDate("returndate"));
				deli.setLname(rs.getString("lname"));
				deliList.add(deli);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return deliList;
	}
	
	public DeliveryVO orderInfo(DeliveryVO vo) {
		System.out.println("===> JDBC orderInfo()");
		try {
			conn = JDBCUtil.getConnection();
			stmt = conn.prepareStatement(ORDER_INFO);
			stmt.setLong(1, vo.getOrdid());
			rs = stmt.executeQuery();
			if(rs.next()) {
				vo.setCid(rs.getString("cid"));
				vo.setOrderdate(rs.getDate("orderdate"));
				vo.setOrdmoney(rs.getInt("ordmoney"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, stmt, conn);
		}
		return vo;
	}
}