package com.mungmungjackjack.mmjj.cart.service.impl;

import java.util.List;
import java.util.Map;

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
	public int addCart(CartDTO cDto) {
		return mapper.addCart(cDto);
	}

	@Override
	public int deleteCart(Map<String, Object> cart) {
		return mapper.deleteCart(cart);
	}

	@Override
	public List<CartDTO> previewCart(String userid) {
		return mapper.previewCart(userid);
	}

}
