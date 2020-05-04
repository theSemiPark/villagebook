
package com.spring.view.ctrl;

import java.sql.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.biz.delivery.DeliveryDAO;
import com.spring.biz.delivery.DeliveryDAO2;
import com.spring.biz.delivery.DeliveryVO;

@Controller
public class DeliveryController {

	@RequestMapping("/delivery.do")
	public String getBoard(DeliveryVO vo, DeliveryDAO boardDAO, Model model) {
		System.out.println("배송 현황 상세 페이지");
		List<DeliveryVO> boardList = boardDAO.getOrdList(vo);
		if(boardList.isEmpty()) return "deliveryHistory.do";
		model.addAttribute("boardList", boardList);
		return "delivery.jsp";
	}
	
	@RequestMapping("/deliveryHistory.do")
	public String getHistory(DeliveryVO vo, DeliveryDAO boardDAO, Model model) {
		System.out.println("배송 히스토리 상세 페이지");
		List<DeliveryVO> boardList = boardDAO.getOrdHistoryList(vo);
		if(boardList.isEmpty()) return "deliveryHistoryList.do";
		model.addAttribute("boardList", boardList);
		return "deliveryHistory.jsp";
	}
	
	@RequestMapping("/deliveryList.do")
	public String getBoardList(HttpSession session, DeliveryVO vo, DeliveryDAO boardDAO, Model model) {
		System.out.println("배송 현황 리스트");
		System.out.println((String)session.getAttribute("cid"));
		vo.setCid((String)session.getAttribute("cid"));
		model.addAttribute("boardList", boardDAO.getOrdidList(vo));
		return "deliveryList.jsp";
	}
	
	@RequestMapping("/deliveryHistoryList.do")
	public String getDeliveryHistory(HttpSession session, DeliveryVO vo, DeliveryDAO boardDAO, Model model) {
		System.out.println("대여 히스토리");
		System.out.println((String)session.getAttribute("cid"));
		vo.setCid((String)session.getAttribute("cid"));
		model.addAttribute("boardList", boardDAO.getOrdidHistoryList(vo));
		return "deliveryHistoryList.jsp";
	}
	
	@RequestMapping("/renewtf.do")
	public String bookRenew(DeliveryVO vo, DeliveryDAO2 delivery, DeliveryDAO boardDAO, Model model) {
		System.out.println("연장 수정");
		System.out.println(vo.getLid() + ":" + vo.getOrdid());
		delivery.getchange(vo);
		delivery.getchange_DATE(vo);
		return "delivery.jsp";
	}
	
	@RequestMapping("/returnwer.do")
	public String bookReturn1(HttpSession session, DeliveryVO vo, DeliveryDAO2 delivery, int late) {
		System.out.println("책 반납1");
		System.out.println(vo.getLid() + ":" + vo.getOrdid() + ":" + late);
		vo.setCid((String)session.getAttribute("cid"));
		delivery.bookReturn1(vo);
		return "delivery.jsp";
	}
	
	@RequestMapping("/returnwer2.do")
	public String bookReturn2(HttpSession session, DeliveryVO vo, DeliveryDAO2 delivery) {
		System.out.println("책 반납2");
		vo.setLid((String)session.getAttribute("lid"));
		vo.setLname((String)session.getAttribute("lname"));
		System.out.println(vo.getLid() + ":" + vo.getOrdid() + ":" + vo.getCid());
		delivery.bookReturn2(vo);
		return "lib_getReturnList.jsp";
	}
	
	@RequestMapping("/getOrder_admin.do")
	public String getOrder_admin(DeliveryDAO deliveryDAO, Model model) {
		System.out.println("관리자용 전체 주문내역");
		model.addAttribute("deliveryList", deliveryDAO.getOrder_admin());
		return "getOrder_admin.jsp";
	}
	
	@RequestMapping("/getOrderLib_admin.do")
	public String getOrderLib_admin(DeliveryVO vo, DeliveryDAO deliveryDAO, Model model, HttpSession session) {
		System.out.println("관리자용 주문번호별 도서관내역");
		model.addAttribute("orderInfo", deliveryDAO.orderInfo(vo));
		model.addAttribute("deliveryList", deliveryDAO.getOrderLib_admin(vo));
		return "getOrderLib_admin.jsp";
	}
	
	@RequestMapping("/getOrderLibBook_admin.do")
	public @ResponseBody List<DeliveryVO> getOrderLibBook_admin(DeliveryVO vo, DeliveryDAO deliveryDAO, HttpSession session) {
		System.out.println("관리자용 주문번호>도서관별 책내역");
		return deliveryDAO.getOrderLibBook_admin(vo);
	}
	
	@RequestMapping("/delivery_cancel.do")
	public String delivery_cancel(DeliveryDAO deliveryDAO, DeliveryVO vo) {
		System.out.println("관리자용 주문취소");
		deliveryDAO.delivery_cancel(vo);
		return "getOrder_admin.jsp";
	}
	
	@RequestMapping("/delete_delivery.do")
	public String delete_delivery(DeliveryDAO deliveryDAO, String input){
		System.out.println("관리자용 주문삭제");
		Date date =  Date.valueOf(input);
		deliveryDAO.delete_past(date);
		System.out.println(date);
		return "getOrder_admin.jsp";
	}
	
	@RequestMapping("/lib_delivery.do")
	public String lib_delivery(DeliveryDAO deliveryDAO, HttpSession session, Model model){
		System.out.println("도서관용 배송정보");
		model.addAttribute("deliList", deliveryDAO.getLibDeliveryList((String)session.getAttribute("lid")));
		return "lib_delivery.jsp";
	}

	@RequestMapping("/lib_deli_detail.do")
	public String lib_deli_detail(DeliveryDAO deliveryDAO, DeliveryVO vo, HttpSession session, Model model){
		System.out.println("도서관용 배송 상세정보");
		vo.setLid((String)session.getAttribute("lid"));
		List<DeliveryVO> detailList = deliveryDAO.getLibDeliDetail(vo);
		model.addAttribute("detailList", detailList);
		model.addAttribute("user", deliveryDAO.getUserInfo(detailList.get(0).getCid()));
		return "lib_deli_detail.jsp";
	}
	
	@RequestMapping("/lib_shipping_update.do")
	public String lib_shipping_update(DeliveryDAO deliveryDAO, DeliveryVO vo, HttpSession session, Model model){
		System.out.println("도서관용 배송상태 업데이트");
		vo.setLid((String)session.getAttribute("lid"));
		deliveryDAO.libShipUpdate(vo);
		return "lib_deli_detail.jsp";
	}
	
	@RequestMapping("/lib_getReturnList.do")
	public String lib_getReturnList(Model model, DeliveryDAO2 deliveryDAO, DeliveryVO vo, HttpSession session) {
		System.out.println("도서관용 반납요청 리스트");
		vo.setLid((String)session.getAttribute("lid"));
		model.addAttribute("returnList", deliveryDAO.lib_getReturnList(vo));
		return "lib_getReturnList.jsp";
	}
	
	
	@RequestMapping("/lib_getReturn_detail.do")
	public @ResponseBody List<DeliveryVO> lib_getReturn_detail(DeliveryDAO2 deliveryDAO, DeliveryVO vo, HttpSession session) {
		System.out.println("도서관용 반납요청 리스트 상세");
		vo.setLid((String)session.getAttribute("lid"));
		return deliveryDAO.lib_getReturn_detail(vo);
	}
	
	@RequestMapping("/getDelivery_admin.do")
	public String getDelivery_admin(DeliveryDAO deliveryDAO, DeliveryVO vo, Model model) {
		System.out.println("관리자용 전체 대여내역");
		model.addAttribute("deliveryList", deliveryDAO.getDelivery_admin(vo));
		return "getDelivery_admin.jsp";
	}
	
	@ModelAttribute("conditionMap_ship")
	public Map<String, String> searchCondtionMap1() {
		Map<String, String> conditionMap = new LinkedHashMap<String, String>();
		conditionMap.put("전체", "0");
		conditionMap.put("배송전", "-1");
		conditionMap.put("배송중", "1");
		conditionMap.put("배송완료", "2");
		conditionMap.put("주문취소", "5");
		return conditionMap;
	}
	
	@ModelAttribute("conditionMap_return")
	public Map<String, String> searchCondtionMap2() {
		Map<String, String> conditionMap = new LinkedHashMap<String, String>();
		conditionMap.put("전체", "");
		conditionMap.put("반납전", "N");
		conditionMap.put("반납요청", "R");
		conditionMap.put("반납완료", "Y");
		return conditionMap;
	}
}

