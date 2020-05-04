package com.spring.biz.cart;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("cartService")
public class CartServiceImpl implements CartService{
	@Autowired
	private CartDAO cartDAO;
	
	public void insertCart(CartVO vo) {
		cartDAO.insertCart(vo);
	}
	
	public void updateCart(CartVO vo) {
		cartDAO.updateCart(vo);
	}
	
	public void deleteCart(CartVO vo) {
		cartDAO.deleteCart(vo);
	}
	
	public List<CartVO> getCart(CartVO vo){
		return cartDAO.getCart(vo);
	}
	
	public String checkCart(CartVO vo) {
		return cartDAO.checkCart(vo);
	}
}