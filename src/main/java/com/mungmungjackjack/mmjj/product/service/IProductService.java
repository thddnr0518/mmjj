package com.mungmungjackjack.mmjj.product.service;

import java.util.List;

import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.product.domain.ProductDTO;
import com.mungmungjackjack.mmjj.product.domain.ProductVO;

public interface IProductService {
	// 상품 등록
	public void insertProduct(ProductDTO pDto)throws Exception;
	// 상품 상세
	public ProductVO readProduct(String product)throws Exception;
	// 상품 수정
    public void updateProduct(ProductDTO pDto)throws Exception;
    // 상품 판매 중단
    public void notUseProduct(String productNo)throws Exception;
    // 상품 리스트
    public List<ProductDTO> listProduct(Criteria cri) throws Exception; //상품 전체 목록
    // 판매중인 상품 개수
    public int getTotalProductCnt(Criteria cri) throws Exception;// 등록된 상품 총 갯수
    // 판매중단된 상품 완전 제거
    public void deleteProuct()throws Exception;
}
