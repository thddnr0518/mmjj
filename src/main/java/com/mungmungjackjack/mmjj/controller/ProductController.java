package com.mungmungjackjack.mmjj.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mungmungjackjack.mmjj.cart.domain.CartDTO;
import com.mungmungjackjack.mmjj.cart.domain.CartVO;
import com.mungmungjackjack.mmjj.cart.service.ICartService;
import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.domain.PageDTO;
import com.mungmungjackjack.mmjj.member.domain.MemberDTO;
import com.mungmungjackjack.mmjj.member.service.IMemberService;
import com.mungmungjackjack.mmjj.order.service.IOrderService;
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
	private IProductService productService;
	
	@Autowired
	private IOrderService orderService;
	
	@Autowired
	private IMemberService memberService;
	
	@Autowired
	private ICartService cartService;
	
	@Resource(name="productThumbPath")
	private String uploadPath;
	
	// 상품 등록 페이지로 이동
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	@PreAuthorize("isAuthenticated()")
	public void registerGET() throws Exception {
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
		
		productService.insertProduct(pDto);
		
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
		List<ProductVO> productVO = productService.listProduct(cri);
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
		int total = productService.getTotalProductCnt(cri);
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	//상품 디테일 , 수정 페이지 진입
	@RequestMapping(value = {"/detail", "/modify"}, method = RequestMethod.GET)
	public void detailGet(@RequestParam("productNo") String productNo, @ModelAttribute("cri") Criteria cri, Model model)throws Exception {
		
		log.info("product detail, update ............GET");
		log.info("productNo : " + productNo);
		
		// 진입할 상품번호를 기준으로 데이터 반환받기
		ProductVO pVO =  productService.detailProduct(productNo);
		
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
	
	// 상품수정
	@PreAuthorize("principal.username == #sallerId")
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String updatePOST(ProductDTO pDto,HttpServletRequest request, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, MultipartFile file, String sallerId) throws Exception {
		log.info("modify ..............POST");
		
		log.info("pDto : " + pDto);
		
		// 새로운 파일이 등록되었는지 확인
		if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
			// 기존 파일 삭제
			new File(uploadPath + request.getParameter("productImg")).delete();
			new File(uploadPath + request.getParameter("productThumb")).delete();
			
			// 새로운 파일 등록
			String imgUploadPath = uploadPath + File.separator + "productThumb";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			String fileName = null;
			
			log.info("ProductDTO : " + pDto);
			log.info("imgUploadPath : " + imgUploadPath);
			log.info("ymdPath : " + ymdPath);
			
			pDto.setProductImg(File.separator + "productThumb" + ymdPath + File.separator + fileName);
			pDto.setProductThumb(File.separator + "productThumb" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
			
		} else { // 새로운 파일이 등록되지 않았다면
			// 기존 이미지로 그대로 사용
			pDto.setProductImg(request.getParameter("productImg"));
			pDto.setProductThumb(request.getParameter("productThumb"));
		}
		

		log.info("updateProduct : " + productService.updateProduct(pDto));
		
		if (productService.updateProduct(pDto)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/product/list" + cri.getListLink();
	}
	
	// 판매자 판매중지
	@PreAuthorize("principal.username == #sallerId")
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam String productNo, String sallerId, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception{
		
		log.info("remove .............");
		
		//List<BoardAttachDTO> attachList = service.getAttachList(productNo);
		
		if(productService.notUseProduct(productNo)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/product/list" + cri.getListLink();
	}
	
	// 단건 주문
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/order", method = RequestMethod.GET)
	public void orderGET(String productNo, String userid, int orderCnt, Model model)throws Exception {
		log.info("product order ............GET");
		
		log.info("productNo : " + productNo);
		log.info("userid : " + userid);
		log.info("orderCnt : " + orderCnt);
		
		// 진입할 상품번호를 기준으로 데이터 반환받기
		ProductVO pVO =  productService.detailProduct(productNo);
		
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
		
		// 화면으로 상품 데이터 넘겨줌
		//model.addAttribute("pDto", pDto);
		
		// 화면으로 회원 데이터 넘겨줌
		MemberDTO mDto =  memberService.selMember(userid);
		//model.addAttribute("mDto", mDto);
		
		Map<String, Object> productOrder = new HashMap<String, Object>();
		
		productOrder.put("pDto", pDto);
		productOrder.put("mDto", mDto);
		productOrder.put("orderCnt", orderCnt);
		
		log.info("pDto : " + pDto);
		
		model.addAttribute("pO", productOrder);
	}
	
	// 장바구니 추가
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/cart",
				consumes = "application/json",
				produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> addCart(@RequestBody CartDTO cDto){
		log.info("addCart .............. ");
		log.info("cDto : " + cDto);
		
		int result = cartService.addCart(cDto);
		
		log.info("1이면 성공 0은 실패 : " + result);
		
		return result == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 장바구니 상세
	@PreAuthorize("principal.username == #userid")
	@RequestMapping(value = "/cartList", method = RequestMethod.GET)
	public void cartListGET(@RequestParam("userid") String userid, @ModelAttribute("cri") Criteria cri, Model model)throws Exception {
		log.info("cartList  ............GET");
		
		log.info("userid  : " + userid);
		
		// 반환된 데이터를 리스트로 담기(VO)
		List<CartVO> cartVO = cartService.listCart(userid);
		// 화면으로 list객체로 보내줄 객체선언(DTO) 
		List<CartDTO> cartDto = new ArrayList<CartDTO>();
		
		// 반복문으로 리스트를 돌려서 VO객체를 DTO객체에 담기
		for (CartVO cVO : cartVO) {
			
			// VO의 데이터를 받을 DTO생성
			CartDTO cDto = new CartDTO();
			
			cDto.setCartNo(cVO.getCart_no());
			cDto.setProductNo(cVO.getProduct_no());
			cDto.setUserid(cVO.getUserid());
			cDto.setProductName(cVO.getProduct_name());
			cDto.setProductCnt(cVO.getProduct_cnt());
			cDto.setProductThumb(cVO.getProduct_thumb());
			cDto.setProductPrice(cVO.getProduct_price());
			cDto.setDeleveryPrice(cVO.getDelevery_price());

			cartDto.add(cDto);
		}
		// 쌓인 DTO리스트 데이터를 화면단으로 list로 보내줌
		model.addAttribute("list", cartDto);
	}
	
	// 장바구니 제거
	@PreAuthorize("principal.username == #userid")
	@ResponseBody
	@RequestMapping(value = "/deleteCart", method = RequestMethod.POST)
	public ResponseEntity<String> deleteCart(@RequestParam(value = "chbox[]") List<String> chArr, String userid) throws Exception {
		log.info("delete cart");
	 
		int result = 0;
		int cartNum = 0;
		
		Map<String, Object> cart = new HashMap<String, Object>();
		
		cart.put("userid", userid);
		
		if (cart != null) {
			for(String i : chArr) {   
				cartNum = Integer.parseInt(i);
				cart.put("cartNo", cartNum);
				
				log.info("cart : " + cart);
				
				cartService.deleteCart(cart);
			}
			result = 1;
		}
		
		log.info("1이면 성공 0은 실패 : " + result);
		
	return result == 1
			? new ResponseEntity<String>("success", HttpStatus.OK)
			: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 장바구니 주문
//	@PreAuthorize("principal.username == #userid")
//	@RequestMapping(value = "/cart", method = RequestMethod.POST)
//	public void cartPOST(String userid, List<String> productNo, List<String> orderCnt, Model model)throws Exception {
//		log.info("cart  ............POST");
//		
//		log.info("productNo : " + productNo);
//		log.info("userid : " + userid);
//		log.info("orderCnt : " + orderCnt);
//		
//		
//		
//		// 진입할 상품번호를 기준으로 데이터 반환받기
////		ProductVO pVO =  productService.detailProduct(productNo);
////		
////		// VO의 데이터를 받을 DTO생성
////		ProductDTO pDto = new ProductDTO();
////		
////		pDto.setProductNo(pVO.getProduct_no());
////		pDto.setSallerId(pVO.getSaller_id());
////		pDto.setProductName(pVO.getProduct_name());
////		pDto.setProductContent(pVO.getProduct_content());
////		pDto.setProductCnt(pVO.getProduct_cnt());
////		pDto.setProductImg(pVO.getProduct_img());
////		pDto.setProductThumb(pVO.getProduct_thumb());
////		pDto.setProductPrice(pVO.getProduct_price());
////		pDto.setDeleveryPrice(pVO.getDelevery_price());
////		pDto.setOrderCnt(pVO.getOrder_cnt());
////		pDto.setProductIndate(pVO.getProduct_indate());
////		pDto.setProductUseyn(pVO.getProduct_useyn());
//		
//		// 화면으로 상품 데이터 넘겨줌
//		//model.addAttribute("pDto", pDto);
//		
//		// 화면으로 회원 데이터 넘겨줌
//		MemberDTO mDto =  memberService.selMember(userid);
//		//model.addAttribute("mDto", mDto);
//		
//		Map<String, Object> productOrder = new HashMap<String, Object>();
//		
////		productOrder.put("pDto", pDto);
////		productOrder.put("mDto", mDto);
////		productOrder.put("orderCnt", orderCnt);
////		
////		log.info("pDto : " + pDto);
////		
////		model.addAttribute("pO", productOrder);
//	}
	
	
	// 주문처리
	@PreAuthorize("principal.username == #userid")
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	public String orderPOST(HttpServletRequest req, String userid, String orderPrice, String deleveryAddress, String productNo, String orderCnt)throws Exception {
		
		log.info("req  : " + req);
		log.info("userid  : " + userid);
		log.info("orderPrice  : " + orderPrice);
		log.info("productNo  : " + productNo);
		log.info("orderCnt  : " + orderCnt);
		
		//orderService.addOrder(oDto, detailList);
		
		
		return "redirect:/product/list";
	}
	
	
	
	// 지우지 말것 자주볼것 Map 객체 이용방법
//	public void nicd() {
//		ProductDTO pDTO = new ProductDTO();
//		MemberDTO mDTO = new MemberDTO();
//		
//		Map<String, Object> nicd = new HashMap<String, Object>();
//		
//		nicd.put("pDTO", pDTO);
//		
//		ProductDTO pDTOa = (ProductDTO)nicd.get("pDTO");
//		
//	}
	
	
}