package com.mungmungjackjack.mmjj.product.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductVO {

	private String 	product_no;
	private String 	saller_id;
    private String 	product_name;
    private String 	product_content;
    private int 	product_cnt;
    private int 	product_price;
    private String	product_img;
    private String	product_thumb;
    private int		delevery_price;
    private String	product_useyn;
    private int		order_cnt;
    private Date	product_indate;
    private String	sal_yn;
    
    private List<ProductVO> poductVO;
}
