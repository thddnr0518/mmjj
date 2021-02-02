package com.mungmungjackjack.mmjj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mungmungjackjack.mmjj.order.domain.ProductOrderDTO;
import com.mungmungjackjack.mmjj.order.service.IOrderService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/order")
@Log4j
public class OrderController {

	@Autowired
	private IOrderService service;
	
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public void order() {
		
	}
	@RequestMapping(value = "ooo", method = RequestMethod.GET)
	@ResponseBody
	public void testOrder(@RequestParam("productNo") String productNo,
			@RequestParam("orderCnt") int orderCnt, ProductOrderDTO pDto){
	
		
	}
	
}