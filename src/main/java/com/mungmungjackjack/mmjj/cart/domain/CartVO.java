package com.mungmungjackjack.mmjj.cart.domain;

import lombok.Data;

@Data
public class CartVO {
	private int cart_no;
	private String userid;
	private String product_no;
	private String product_name;
	private String product_cnt;
	private String product_thumb;
	private String product_price;
	private String delevery_price;
}
