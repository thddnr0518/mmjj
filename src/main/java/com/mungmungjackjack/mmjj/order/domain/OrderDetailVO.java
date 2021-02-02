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
	private String order_no;
	private int order_cnt;
	private String order_confirm;
}
