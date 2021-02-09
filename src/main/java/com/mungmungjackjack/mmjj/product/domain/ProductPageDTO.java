package com.mungmungjackjack.mmjj.product.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ProductPageDTO {
	private int proCnt;
	private List<ProductDTO> list;
}
