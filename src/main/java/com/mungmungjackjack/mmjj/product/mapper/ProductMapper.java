package com.mungmungjackjack.mmjj.product.mapper;

import java.util.List;
import java.util.Map;

import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.product.domain.ProductAttachDTO;
import com.mungmungjackjack.mmjj.product.domain.ProductDTO;
import com.mungmungjackjack.mmjj.product.domain.ProductVO;

public interface ProductMapper {
	// 상품 등록
	public void insertProduct(ProductDTO pDto)throws Exception;
	// 상품 리스트
	public List<ProductVO> listProduct(Criteria cri) throws Exception;
	// 상품 상세
	public ProductVO detailProduct(String productNo)throws Exception;
	// 상품 수정
	public int updateProduct(ProductDTO pDto)throws Exception;
	
	// 상품 번호 취득
	public Map<String, String> findByProduct(Map<String, String> map)throws Exception;
	// 상품 대표이미지 등록
	public void thumbnailRegit(ProductAttachDTO paDto)throws Exception;
    // 상품 판매 중단
    public void notUseProduct(String productNo)throws Exception;
    // 판매중인 상품 개수
    public int getTotalProductCnt(Criteria cri) throws Exception;
    // 배치로 상품 완전 제거
    public int deleteProduct() throws Exception;
    
}
