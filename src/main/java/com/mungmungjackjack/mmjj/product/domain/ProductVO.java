package com.mungmungjackjack.mmjj.product.domain;

import lombok.Data;

@Data
public class ProductVO {

	private String product_no;
	private int saller_no;
    private String product_name;
    private String product_content;
    private int product_cnt;
    private int product_price;
    private int delevery_price;
    private String product_useyn;
    private int order_cnt;
    
}
