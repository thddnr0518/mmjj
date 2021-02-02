package com.mungmungjackjack.mmjj.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mungmungjackjack.mmjj.board.domain.BoardDTO;
import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.domain.PageDTO;
import com.mungmungjackjack.mmjj.product.domain.ProductDTO;
import com.mungmungjackjack.mmjj.product.domain.ProductVO;
import com.mungmungjackjack.mmjj.product.service.IProductService;
import com.mungmungjackjack.mmjj.util.UploadFileUtils;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/product")
@Log4j
public class ProductController {

	@Autowired
	private IProductService service;
	
	@Resource(name="productThumbPath")
	private String uploadPath;
	
	// 상품 등록 페이지로 이동
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	@PreAuthorize("isAuthenticated()")
	public void registerGET(ProductDTO pDto, Model model) throws Exception {
		log.info("register get.............");
	}
		
	// 상품 등록
	@RequestMapping(value = "/register",method = RequestMethod.POST)
	@PreAuthorize("isAuthenticated()")
	public String registerPOST(ProductDTO pDto, MultipartFile file) throws Exception{
		log.info("register post.............");
		log.info("ProductDTO : " + pDto.toString());
		
		String imgUploadPath = uploadPath + File.separator + "productThumb";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		
		log.info("ProductDTO : " + pDto);
		log.info("imgUploadPath : " + imgUploadPath);
		log.info("ymdPath : " + ymdPath);

		if(file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
			
		} else {
			
			fileName = uploadPath + File.separator + "img" + File.separator + "none.png";
		}
		
		pDto.setProductImg(File.separator + "productThumb" + ymdPath + File.separator + fileName);
		pDto.setProductThumb(File.separator + "productThumb" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		
		service.insertProduct(pDto);
		
		return "redirect:/product/list";
	}
		
	// 상품목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void listAll(Criteria cri, Model model) throws Exception {
		
		if (cri.getAmount() == 10) {
			cri.setAmount(30);
			log.info("show all productList ....." + cri);
		}
		
		// 반환된 데이터를 리스트로 담기(VO)
		List<ProductVO> productVO = service.listProduct(cri);
		// 화면으로 list객체로 보내줄 객체선언(DTO) 
		List<ProductDTO> productDto = new ArrayList<ProductDTO>();
		
		// 반복문으로 리스트를 돌려서 VO객체를 DTO객체에 담기
		for (ProductVO pVO : productVO) {
			
			// VO의 데이터를 받을 DTO생성
			ProductDTO pDto = new ProductDTO();
			
			pDto.setProductNo(pVO.getProduct_no());
			pDto.setSallerId(pVO.getSaller_id());
			pDto.setProductName(pVO.getProduct_name());
			pDto.setProductContent(pVO.getProduct_content());
			pDto.setProductCnt(pVO.getProduct_cnt());
			pDto.setProductImg(pVO.getProduct_img());
			pDto.setProductThumb(pVO.getProduct_thumb());
			pDto.setProductPrice(pVO.getProduct_price());
			pDto.setDeleveryPrice(pVO.getDelevery_price());
			pDto.setOrderCnt(pVO.getOrder_cnt());
			pDto.setProductIndate(pVO.getProduct_indate());
			pDto.setProductUseyn(pVO.getProduct_useyn());
			
			// DTO를 리스트로 쌓기
			productDto.add(pDto);
		}
			
		
		// 쌓인 DTO리스트 데이터를 화면단으로 list로 보내줌
		model.addAttribute("list", productDto);
		
		// 총 상품등록된 갯수
		int total = service.getTotalProductCnt(cri);
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	//상품 디테일 , 수정 페이지 진입
	@RequestMapping(value = {"/detail", "/update"}, method = RequestMethod.GET)
	public void detailGet(@RequestParam("productNo") String productNo, @ModelAttribute("cri") Criteria cri, Model model)throws Exception {
		
		log.info("product detail, update ............GET");
		log.info("product : " + productNo);
		
		// 진입할 상품번호를 기준으로 데이터 반환받기
		ProductVO pVO =  service.detailProduct(productNo);
		
		// VO의 데이터를 받을 DTO생성
		ProductDTO pDto = new ProductDTO();
		
		pDto.setProductNo(pVO.getProduct_no());
		pDto.setSallerId(pVO.getSaller_id());
		pDto.setProductName(pVO.getProduct_name());
		pDto.setProductContent(pVO.getProduct_content());
		pDto.setProductCnt(pVO.getProduct_cnt());
		pDto.setProductImg(pVO.getProduct_img());
		pDto.setProductThumb(pVO.getProduct_thumb());
		pDto.setProductPrice(pVO.getProduct_price());
		pDto.setDeleveryPrice(pVO.getDelevery_price());
		pDto.setOrderCnt(pVO.getOrder_cnt());
		pDto.setProductIndate(pVO.getProduct_indate());
		pDto.setProductUseyn(pVO.getProduct_useyn());
		
		log.info("pDto : " + pDto);
		
		// 화면으로 DTO 데이터 넘겨줌
		model.addAttribute("pDto", pDto);
	}
	
	//상품 디테일
//	@RequestMapping("/detail/{productNo}")
//	public ModelAndView detail(@PathVariable("productNo")String productNo, ModelAndView mav)throws Exception {
//		
//		log.info("product detail .....");
//		log.info("product : " + productNo);
//		
//		mav.setViewName("/product/detail");
//		mav.addObject("pDto", service.readProduct(productNo));
//		
//		return mav;
//	}
	
	// 상품수정
	@PreAuthorize("principal.username == #pDto.sallerId")
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String updatePOST(ProductDTO pDto, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception {
		log.info("modify ..............POST" + service.updateProduct(pDto));
		
		if (service.updateProduct(pDto)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/product/list" + cri.getListLink();
	}
	
	
	
	
}