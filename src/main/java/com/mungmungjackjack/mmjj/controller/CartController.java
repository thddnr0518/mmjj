package com.mungmungjackjack.mmjj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mungmungjackjack.mmjj.cart.service.ICartService;
import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.product.domain.ProductDTO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cart")
@Log4j
public class CartController {

	@Autowired
	private ICartService service;
	
	// 장바구니 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void listAll(Criteria cri, Model model) throws Exception {
		
		log.info("show all cartList ....." + cri);

		//String productNo =  service.readCart(cri);
		//model.addAttribute("list",service.listProduct(cri)); // 반환된 데이터 화면단으로 list로 보내줌
		//int total = service.getTotalProductCnt(cri); // 총 상품등록된 갯수
		//log.info("total : " + total);
		
		//model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	@PreAuthorize("isAuthenticated()")
	public void registerGET(ProductDTO pDto, Model model) throws Exception {
		log.info("register get.............");
	}
	
	
}