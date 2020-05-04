package com.spring.biz.delivery;

import java.util.List;

public class DeliveryListVO {
	private List<DeliveryVO> list;
	
	public List<DeliveryVO> getList() {
		return list;
	}
	public void setList(List<DeliveryVO> list) {
		this.list = list;
	}

	public String toString() {
		return "DeliveryListVO [list=" + list + "]";
	}
}
