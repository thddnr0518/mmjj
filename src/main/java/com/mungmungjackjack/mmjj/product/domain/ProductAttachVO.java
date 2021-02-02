package com.mungmungjackjack.mmjj.product.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductAttachVO {

	private String uuid;
	private String product_no;
	private String file_name;
	
	private List<ProductAttachVO> attachList;
}
