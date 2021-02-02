package com.mungmungjackjack.mmjj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mungmungjackjack.mmjj.order.domain.OrderDetailDTO;
import com.mungmungjackjack.mmjj.order.domain.ProductOrderDTO;
import com.mungmungjackjack.mmjj.order.service.IOrderService;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
					"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class OrderTest {

	@Autowired
	private IOrderService service;
	
	// 상품 주문 (결제후 주문번호 발급) @@
	@Test
	public void addOrderTest() {
		String userid = "admin0";
		int orderPrice = 30000;
		String payType = "a";
		String deleveryAddress = "한경원5층";
		String orderName = "최송욱";
		String orderPhone = "010101010101";
		
		ProductOrderDTO oDto = new ProductOrderDTO();
		
		oDto.setUserid(userid);
		oDto.setOrderPrice(orderPrice);
		oDto.setPayType(payType);
		oDto.setDeleveryAddress(deleveryAddress);
		oDto.setOrderName(orderName);
		oDto.setOrderPhone(orderPhone);
		
		List<Map<String, Object>> orderList = new ArrayList<Map<String,Object>>();
		
		for (int i = 0; i < orderList.size(); i++) {
			
			Map<String, Object> order = new HashMap<String, Object>();
			
			String productNo = "p125";
			int orderCnt = 30;
			
//			order.put("orderCnt", );
//			
//			dDto.setProductNo(productNo);
//			dDto.setOrderCnt(orderCnt);
			service.addOrder(oDto, orderList);
			
			orderList.add(order);
		}
	}
	
	// 주문 상세 등록(하나의 주문번호의 상품마다 등록)
//	@Test
//	public void addDetailTest() {
//		
//	}
	
	// 회원 주문 목록 삭제 @@
//	@Test
//	public void notUseOrderTest() {
//		String orderNo = "25";
//		service.notUseOrder(orderNo);
//		String orderNo2 = "26";
//		service.notUseOrder(orderNo2);
//		
//	}
	
	// 판매자의 판매상품 목록 @@
//	@Test
//	public void sallerProductTest() { 
//		String sallerId = "rlaworhkd3";
//		service.sallerProduct(sallerId);
//	}
	
	// 판매자의 발주 대기 목록 @@
//	@Test
//	public void orderReadyTest() {
//		String sallerId = "rlaworhkd3";
//		service.orderReady(sallerId);
//	}
	
	// 판매자의 발주된 목록 @@
//	@Test
//	public void orderShipped() {
//		String sallerId = "rlaworhkd3";
//		service.orderShipped(sallerId);
//	}
	
	// 구매자 정보 @@
//	@Test
//	public void orderInfo() {
//		String sallerId = "rlaworhkd3";
//		service.orderInfo(sallerId);
//	}
	
	// 배치 시 주문 삭제 @@
//	@Test
//	public void deleteOrderTest() {
//		service.deleteOrder();
//	}
	
	// 회원 주문 목록 @@
//	@Test
//	public void listOrderTest() {
//		String userid = "admin0";
//		service.listOrder(userid);
//	}
	
	
	
}
