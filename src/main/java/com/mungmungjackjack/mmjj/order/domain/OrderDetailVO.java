package com.mungmungjackjack.mmjj.order.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailVO {

	private String detail_no;
	private String product_no;
	private String order_mo;
	private int order_cnt;
	private String delevery_address;
	private String order_phone;
	private int order_sales;
	private String pay_type;
}
