package com.mungmungjackjack.mmjj.product.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.product.domain.ProductDTO;
import com.mungmungjackjack.mmjj.product.domain.ProductVO;
import com.mungmungjackjack.mmjj.product.mapper.ProductMapper;
import com.mungmungjackjack.mmjj.product.service.IProductService;

@Service
public class ProductServiceImpl implements IProductService{

	@Autowired
	private ProductMapper mapper;

	@Override
	public void insertProduct(ProductDTO pDto) throws Exception{
		mapper.insertProduct(pDto);
	}

	@Override
	public ProductVO readProduct(String productNo)throws Exception {
		
		return mapper.readProduct(productNo);
	}

	@Override
	public void updateProduct(ProductDTO pDto)throws Exception {
		mapper.updateProduct(pDto);
		
	}

	@Override
	public void notUseProduct(String productNo)throws Exception {
		mapper.notUseProduct(productNo);
		
	}

	@Override
	public List<ProductDTO> listProduct(Criteria cri) throws Exception {
		return mapper.listProduct(cri);
	}

	@Override
	public int getTotalProductCnt(Criteria cri) throws Exception {
		return mapper.getTotalProductCnt(cri);
	}

	@Override
	public void deleteProuct() throws Exception {
		mapper.deleteProduct();
	}
	

}
