package com.mungmungjackjack.mmjj;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mungmungjackjack.mmjj.cart.domain.CartDTO;
import com.mungmungjackjack.mmjj.cart.domain.CartVO;
import com.mungmungjackjack.mmjj.cart.service.ICartService;
import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.member.domain.MemberDTO;
import com.mungmungjackjack.mmjj.member.mapper.MemberMapper;
import com.mungmungjackjack.mmjj.product.domain.ProductDTO;
import com.mungmungjackjack.mmjj.product.domain.ProductVO;
import com.mungmungjackjack.mmjj.product.service.IProductService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
					"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class ProductTest {

	@Autowired
	private IProductService service;
	
	// 상품등록
//	@Test
//	public void insertTest() throws Exception {
//		int sallerNo = 24;
//		String productName = "재광이가 만든 몽둥이";
//		String productContent = "장인 김재광씨가 만든 몽둥이 입니다";
//		int productCnt = 10;
//		int productPrice = 20000;
//		int deleveryPrice = 5000;
//		
//		ProductDTO pDto = new ProductDTO();
//		pDto.setSallerNo(sallerNo);
//		pDto.setProductName(productName);
//		pDto.setProductContent(productContent);
//		pDto.setProductCnt(productCnt);
//		pDto.setProductPrice(productPrice);
//		pDto.setDeleveryPrice(deleveryPrice);
//		
//		service.insertProduct(pDto);
//	}
	
	// 상품 리스트
//	@Test
//	public void listTest() throws Exception {
//		Criteria cri = new Criteria();
//		service.listProduct(cri);
//		
//	}
		
	// 판매중인 상품 개수
//	@Test
//	public void totalTest() throws Exception {
//		Criteria cri = new Criteria();
//		service.getTotalProductCnt(cri);
//	}
	
	// 상품 상세
//	@Test
//	public void previewTest()throws Exception {
//		
//		String productNo = "p85";
//		service.readProduct(productNo);
//	}
	
	// 상품 수정
//	@Test
//	public void listTest()throws Exception {
//		ProductDTO pDto = new ProductDTO();
//		
//		String productName = "오리뼈";
//		String productContent = "오리뼈 굳";
//		int productCnt = 50;
//		int productPrice = 50000;
//		int deleveryPrice = 3500;
//		
//		pDto.setProductNo("p85");
//		pDto.setProductName(productName);
//		pDto.setProductContent(productContent);
//		pDto.setProductCnt(productCnt);
//		pDto.setProductPrice(productPrice);
//		pDto.setDeleveryPrice(deleveryPrice);
//		
//		service.updateProduct(pDto);
//	}
	
	// 상품 판매 중단
//	@Test
//	public void notUseTest()throws Exception {
//		String productNo = "97";
//		service.notUseProduct(productNo);
//		String productNo2 = "98";
//		service.notUseProduct(productNo2);
//		String productNo3 = "99";
//		service.notUseProduct(productNo3);
//		String productNo4 = "107";
//		service.notUseProduct(productNo4);
//		String productNo5 = "108";
//		service.notUseProduct(productNo5);
//	}
	
	// 상품 제거
//	@Test
//	public void deleteTest()throws Exception {
//		service.deleteProuct();
//	}
	
	
}
