package com.mungmungjackjack.mmjj.product.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDTO {

	private String productNo;
	private int sallerNo;
    private String productName;
    private String productContent;
    private int productCnt;
    private int productPrice;
    private int deleveryPrice;
    private String productUseyn;
    private int orderCnt;
    private String salYn;
    
    private List<ProductAttachDTO> attachList;
}
