package com.mungmungjackjack.mmjj.member.domain;

import lombok.Data;

@Data
public class ResponseDataDTO {

	private String code;
	private String status;
	private String message;
	private Object item;
}
