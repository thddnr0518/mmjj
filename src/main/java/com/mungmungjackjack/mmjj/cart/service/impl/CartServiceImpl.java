package com.mungmungjackjack.mmjj.cart.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mungmungjackjack.mmjj.cart.domain.CartDTO;import com.mungmungjackjack.mmjj.cart.domain.CartVO;
import com.mungmungjackjack.mmjj.cart.mapper.CartMapper;
import com.mungmungjackjack.mmjj.cart.service.ICartService;

@Service
public class CartServiceImpl implements ICartService{

	@Autowired
	private CartMapper mapper;
	
	@Override
	public List<CartVO> listCart(String userid) {
		return mapper.listCart(userid);
	}

	@Override
	public void addCart(CartDTO cDto) {
		mapper.addCart(cDto);
	}

	@Override
	public void deleteCart(String cartNo) {
		mapper.deleteCart(cartNo);
	}

	@Override
	public List<CartDTO> previewCart(String userid) {
		return mapper.previewCart(userid);
	}

}
