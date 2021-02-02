package com.mungmungjackjack.mmjj.order.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductOrderVO {

	private String order_no;
	private String userid;
	private String delevery_address;
	private String order_phone;
	private int order_price;
	private String pay_type;
	private Date order_date;
	private String order_useyn;
	private String order_name;
}
