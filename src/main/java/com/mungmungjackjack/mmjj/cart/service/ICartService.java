package com.mungmungjackjack.mmjj.cart.service;

import java.util.List;

import com.mungmungjackjack.mmjj.cart.domain.CartDTO;
import com.mungmungjackjack.mmjj.cart.domain.CartVO;

public interface ICartService {

	// 장바구니 목록
	public List<CartVO> listCart(String userid);
	// 장바구니 추가
	public void addCart(CartDTO cDto);
	// 미리보기 5개
	public List<CartDTO> previewCart(String userid);
	// 장바구니 제거
	public void deleteCart(String cartNo);
	
}
