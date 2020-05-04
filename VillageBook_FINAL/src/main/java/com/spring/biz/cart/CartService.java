package com.spring.biz.cart;

import java.util.List;

public interface CartService {
	void insertCart(CartVO vo);
	void updateCart(CartVO vo);
	void deleteCart(CartVO vo);
	List<CartVO> getCart(CartVO vo);
	String checkCart(CartVO vo);
}
