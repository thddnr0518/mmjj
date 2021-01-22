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
import com.mungmungjackjack.mmjj.member.domain.MemberDTO;
import com.mungmungjackjack.mmjj.member.mapper.MemberMapper;
import com.mungmungjackjack.mmjj.product.service.IProductService;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
					"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class CartTest {

	@Autowired
	private ICartService service;
	
	// 장바구니 목록
//	@Test
//	public void listTest() {
//		String userid = "admin0";
//		service.listCart(userid);
//	}
		
	// 장바구니 추가
//	@Test
//	public void addTest() {
//		CartDTO cDto = new CartDTO();
//		cDto.setProductNo("p90");
//		cDto.setUserid("admin0");
//		service.addCart(cDto);
//	}
	
	// 상품 미리보기 5개
//	@Test
//	public void previewTest() {
//		service.previewCart("admin0");
//	}
	
	// 장바구니에서 제거
	@Test
	public void deleteTest() {
		service.deleteCart("20");
	}
	
}
