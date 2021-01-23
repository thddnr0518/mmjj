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
	private Date order_date;
	private int order_price;
	private char pay_type;
}
