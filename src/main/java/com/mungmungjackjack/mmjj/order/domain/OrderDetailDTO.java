package com.mungmungjackjack.mmjj.order.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailDTO {

	private String detailNo;
	private String productNo;
	private String orderNo;
	private int orderCnt;
	private String orderConfirm;
	
	private List<OrderDetailDTO> orderList;
}
