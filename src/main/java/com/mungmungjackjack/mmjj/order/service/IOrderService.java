package com.mungmungjackjack.mmjj.order.service;

import java.util.List;
import java.util.Map;

import com.mungmungjackjack.mmjj.order.domain.OrderDetailVO;
import com.mungmungjackjack.mmjj.order.domain.ProductOrderDTO;
import com.mungmungjackjack.mmjj.order.domain.ProductOrderVO;
import com.mungmungjackjack.mmjj.product.domain.ProductDTO;
import com.mungmungjackjack.mmjj.product.domain.ProductVO;


public interface IOrderService {
	// 상품 주문 (결제후 주문번호 발급, 상품마다 주문상세 등록)
	public void addOrder(ProductOrderDTO oDto, List<Map<String, Object>> detailList);
	
	// 체크 상품 리스트
	public List<ProductOrderDTO> checkInProduct(List<Map<String, Object>> checkInProduct);
	
	// 회원 주문 목록
	public List<ProductOrderVO> listOrder(String userid);
	// 회원 주문 목록 삭제
	public void notUseOrder(String orderNo);
	// 판매자의 판매상품 목록
	public List<ProductVO> sallerProduct(String sallerId);
	// 판매자의 발주 대기 목록
	public List<OrderDetailVO> orderReady(String sallerId);
	// 판매자의 발주된 목록
	public List<OrderDetailVO> orderShipped(String sallerId);
	// 구매자 정보
	public List<ProductOrderVO> orderInfo(String sallerId);
	// 배치 시 주문 삭제
	public void deleteOrder();
}
