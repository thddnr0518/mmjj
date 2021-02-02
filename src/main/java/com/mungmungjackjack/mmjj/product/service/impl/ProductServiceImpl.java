package com.mungmungjackjack.mmjj.product.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.product.domain.ProductAttachDTO;
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
	public ProductVO detailProduct(String productNo)throws Exception {
		return mapper.detailProduct(productNo);
	}

	@Override
	public boolean updateProduct(ProductDTO pDto)throws Exception {
		boolean updateResult = mapper.updateProduct(pDto) == 1;
		
		return updateResult;
	}

	@Override
	public void notUseProduct(String productNo)throws Exception {
		mapper.notUseProduct(productNo);
		
	}

	@Override
	public List<ProductVO> listProduct(Criteria cri) throws Exception {
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

	@Override
	public Map<String, String> productAttachList(Map<String, String> map) throws Exception{
		return mapper.findByProduct(map);
	}

	@Override
	public void thumbnailRegit(ProductAttachDTO paDto) throws Exception{
		mapper.thumbnailRegit(paDto);
	}

	

}
