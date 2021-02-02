package com.mungmungjackjack.mmjj.product.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductAttachDTO {

	private String uuid;
	private String productNo;
	private String fileName;
	
	private List<ProductAttachDTO> attachList;
}
