package com.mungmungjackjack.mmjj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.domain.PageDTO;
import com.mungmungjackjack.mmjj.product.domain.ProductDTO;
import com.mungmungjackjack.mmjj.product.service.IProductService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/product")
@Log4j
public class ProductController {

	@Autowired
	private IProductService service;
	
	//상품목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void listAll(Criteria cri, Model model) throws Exception {
		
		log.info("show all productList ....." + cri);

		if (cri.getAmount() == 10) {
			cri.setAmount(30);
		}
		model.addAttribute("list", service.listProduct(cri)); // 반환된 데이터 화면단으로 list로 보내줌
		
		int total = service.getTotalProductCnt(cri); // 총 상품등록된 갯수
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	//상품 디테일
	@RequestMapping("/detail/{productNo}")
	public ModelAndView detail(@PathVariable("productNo") String productNo, ModelAndView mav)throws Exception {
		
		log.info("product detail .....");
		log.info("product : " + productNo);
		
		mav.setViewName("/product/detail");
		mav.addObject("pDto", service.readProduct(productNo));
		
		return mav;
	}
	
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	@PreAuthorize("isAuthenticated()")
	public void registerGET(ProductDTO pDto, Model model) throws Exception {
		log.info("register get.............");
	}
	
	@RequestMapping(value = "/register",method = RequestMethod.POST)
	@PreAuthorize("isAuthenticated()")
	public String registerPOST(ProductDTO pDto, RedirectAttributes rttr) throws Exception{
		log.info("register post.............");
		log.info("ProductDTO : " + pDto.toString());
		
		service.insertProduct(pDto);
		
		return "redirect:/product/list";
	}
	
}