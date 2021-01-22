package com.mungmungjackjack.mmjj.product.domain;

import java.util.List;

import lombok.Data;

@Data
public class ProductAttachDTO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private String productNo;
	
	private int replycnt;
	private List<ProductAttachDTO> attachList;
}
