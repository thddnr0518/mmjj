package com.mungmungjackjack.mmjj.cart.mapper;

import java.util.List;
import java.util.Map;

import com.mungmungjackjack.mmjj.cart.domain.CartDTO;
import com.mungmungjackjack.mmjj.cart.domain.CartVO;

public interface CartMapper {
	// 장바구니 추가
	public int addCart(CartDTO cDto);

	// 장바구니 목록
	public List<CartVO> listCart(String userid);
	// 미리보기 5개
	public List<CartDTO> previewCart(String userid);
	// 장바구니 제거
	public int deleteCart(Map<String, Object> cart);
	
}