package com.spring.view.ctrl;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.biz.cart.CartService;
import com.spring.biz.cart.CartVO;
import com.spring.biz.user.UserDAO;
import com.spring.biz.user.UserVO;

@Controller
public class CartController {
	@Autowired
	private CartService cartService;

	@RequestMapping("/insertCart.do")
	public String insertCart(CartVO vo, HttpSession session) throws IOException {
		vo.setcId((String) session.getAttribute("cid"));
		cartService.insertCart(vo);
		return "getCart.do";
	}

	@RequestMapping("/updateCart.do")
	public String updateCart(CartVO vo, HttpSession session) throws IOException {
		vo.setcId((String) session.getAttribute("cid"));
		cartService.updateCart(vo);
		return "getCart.do";
	}

	@RequestMapping("/deleteCart.do")
	public String deleteCart(CartVO vo, HttpSession session) {
		vo.setcId((String) session.getAttribute("cid"));
		cartService.deleteCart(vo);
		return "getCart.do";
	}

	@RequestMapping("/getCart.do")
	public String getCart(CartVO vo, Model model, HttpSession session, UserVO user, UserDAO userDAO) {
		vo.setcId((String) session.getAttribute("cid"));
		model.addAttribute("cartList", cartService.getCart(vo));
		
		user.setCid((String) session.getAttribute("cid"));
		user = userDAO.getUserInfo(user);
		session.setAttribute("user", user);

		return "getCartList.jsp";
	}

	@RequestMapping(value = "/checkVali.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String checkVali(CartVO vo, HttpSession session, UserDAO userDAO) throws UnsupportedEncodingException {
		vo.setcId((String) session.getAttribute("cid"));
		
		UserVO user = new UserVO();
		user = userDAO.getUserInfo(user);		
		String result = cartService.checkCart(vo);
		System.out.println("alert : [" + result + "]");
		URLEncoder.encode(result , "UTF-8");
		return result;
	}

}