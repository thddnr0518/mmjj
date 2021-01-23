package com.mungmungjackjack.mmjj.order.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductOrderDTO {

	private String orderNo;
	private String userid;
	private Date orderDate;
	private int orderPrice;
	private char payType;
}
