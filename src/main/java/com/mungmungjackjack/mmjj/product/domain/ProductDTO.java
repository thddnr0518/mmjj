package com.mungmungjackjack.mmjj.product.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDTO {

	private String 	productNo;
	private String 	sallerId;
    private String 	productName;
    private String 	productContent;
    private int 	productCnt;
    private int 	productPrice;
    private String	productImg;
    private String	productThumb;
    private int		deleveryPrice;
    private String	productUseyn;
    private int		orderCnt;
    private Date	productIndate;
    private String	salYn;
    
    private List<ProductDTO> pDto;
    
    private List<ProductAttachDTO> attachList;
}
