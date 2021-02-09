package com.mungmungjackjack.mmjj.cart.domain;

import lombok.Data;

@Data
public class CartDTO {
	private int cartNo;
	private String userid;
	private String productNo;
	private String productName;
	private String productCnt;
	private String productThumb;
	private String productPrice;
	private String deleveryPrice;
}
