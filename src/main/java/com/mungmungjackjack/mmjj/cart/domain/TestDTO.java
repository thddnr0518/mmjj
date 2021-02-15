package com.mungmungjackjack.mmjj.cart.domain;

import java.util.List;

import lombok.Data;

@Data
public class TestDTO {
	private int cartNo;
	private int cartCnt;
	
	private List<TestDTO> testDto;
	
}
