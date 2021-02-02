package com.mungmungjackjack.mmjj.order.mapper;

import java.util.List;
import java.util.Map;

import com.mungmungjackjack.mmjj.order.domain.OrderDetailDTO;
import com.mungmungjackjack.mmjj.order.domain.OrderDetailVO;
import com.mungmungjackjack.mmjj.order.domain.ProductOrderDTO;
import com.mungmungjackjack.mmjj.order.domain.ProductOrderVO;
import com.mungmungjackjack.mmjj.product.domain.ProductVO;

public interface OrderMapper {
	// 체크 상품 리스트
	public List<ProductOrderDTO> checkProduct(Map<String, Object> checkInProduct);
	// 상품 주문 (결제후 주문번호 발급)
	public void addOrder(ProductOrderDTO oDto);
	// 주문 상세 등록(하나의 주문번호/ 상품마다 주문상세 발급)
	public void addDetail(OrderDetailDTO dDto);
	// 주문 시 상품 수량 조절
	public void orderProductCnt(Map<String, Object> update);
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
	// 배치 시 디테일 삭제
	public void deleteDetail();
	// 배치 시 주문 삭제
	public void deleteOrder();
}
