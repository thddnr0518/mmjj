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
	private String deleveryAddress;
	private String orderPhone;
	private int orderPrice;
	private String payType;
	private Date orderDate;
	private String orderUseyn;
	private String orderName;
}
