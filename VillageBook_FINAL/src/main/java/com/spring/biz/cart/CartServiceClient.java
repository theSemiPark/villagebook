package com.spring.biz.cart;

import java.util.List;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class CartServiceClient {
	public static void main(String[] args) {
		AbstractApplicationContext container = new GenericXmlApplicationContext("applicationContext.xml");

		CartService cartService = (CartService) container.getBean("cartService");

//		CartVO vo = new CartVO();
//		vo.setTitle("임시 제목");
//		vo.setWriter("홍길동");
//		vo.setContent("임시 내용...............");
//		boardService.insertBoard(vo);

		CartVO vo = new CartVO();
		vo.setcId("001");
		List<CartVO> cartList = cartService.getCart(vo);
		for (CartVO cart : cartList) {
			System.out.println("---> " + cart.toString());
		}

		container.close();
	}
}
