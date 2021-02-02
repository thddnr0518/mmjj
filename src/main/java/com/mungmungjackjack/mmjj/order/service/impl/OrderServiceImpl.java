package com.mungmungjackjack.mmjj.order.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mungmungjackjack.mmjj.order.domain.OrderDetailDTO;
import com.mungmungjackjack.mmjj.order.domain.OrderDetailVO;
import com.mungmungjackjack.mmjj.order.domain.ProductOrderDTO;
import com.mungmungjackjack.mmjj.order.domain.ProductOrderVO;
import com.mungmungjackjack.mmjj.order.mapper.OrderMapper;
import com.mungmungjackjack.mmjj.order.service.IOrderService;
import com.mungmungjackjack.mmjj.product.domain.ProductVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class OrderServiceImpl implements IOrderService{

	@Autowired
	private OrderMapper mapper;
	
	@Transactional
	@Override
	public void addOrder(ProductOrderDTO oDto, List<Map<String, Object>> detailList) {
		
		log.info("In addOrder........................");
		
		mapper.addOrder(oDto);
		log.info("1test : " + oDto);
		
		for (int i = 0; i < detailList.size(); i++) {
		
			OrderDetailDTO dDto = new OrderDetailDTO();
			
			// 생성된 주문번호로 주문상세에서 참조
			dDto.setOrderNo(oDto.getOrderNo());
			
			mapper.addDetail(dDto);
			log.info("dDto : " + dDto);
			
			// 넘겨받은 상품번호와 주문수량을 참조
			Map<String, Object> update = new HashMap<String, Object>();
			
			update.put("orderCnt", dDto.getOrderCnt());
			update.put("productNo", dDto.getProductNo());
			
			mapper.orderProductCnt(update);
		}
		
	}

	@Override
	public List<ProductOrderVO> listOrder(String userid) {
		return mapper.listOrder(userid);
	}

	@Override
	public void notUseOrder(String orderNo) {
		mapper.notUseOrder(orderNo);
	}

	@Override
	public List<ProductVO> sallerProduct(String sallerId) {
		return mapper.sallerProduct(sallerId);
	}

	@Override
	public List<OrderDetailVO> orderReady(String sallerId) {
		return mapper.orderReady(sallerId);
	}

	@Override
	public List<OrderDetailVO> orderShipped(String sallerId) {
		return mapper.orderShipped(sallerId);
	}

	@Override
	public List<ProductOrderVO> orderInfo(String sallerId) {
		return mapper.orderInfo(sallerId);
	}

	@Override
	public void deleteOrder() {
		mapper.deleteDetail();
		mapper.deleteOrder();
	}

	@Override
	public List<ProductOrderDTO> checkInProduct(List<Map<String, Object>> checkInProduct) {
		Map<String, Object> checkProduct = new HashMap<String, Object>();
		return mapper.checkProduct(checkProduct);
	}

}
