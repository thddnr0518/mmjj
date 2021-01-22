package com.mungmungjackjack.mmjj.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.reply.domain.ReplyDTO;
import com.mungmungjackjack.mmjj.reply.domain.ReplyPageDTO;
import com.mungmungjackjack.mmjj.reply.service.IReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/replies")
@AllArgsConstructor
@Log4j
public class ReplyController {

	private IReplyService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new",
					consumes = "application/json",
					produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> creat(@RequestBody ReplyDTO replyDto){
		log.info("ReplyDTO : " + replyDto);
		
		int insertCount = service.register(replyDto);
		
		log.info("Reply INSERT COUNT : " + insertCount);
		
		return insertCount == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/pages/{bno}/{page}",
			produces = {MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page,
												  @PathVariable("bno") int bno) {
		Criteria cri = new Criteria(page, 10);
		
		log.info("get Reply List bno : " + bno);
		log.info("cri : " + cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	
	@GetMapping(value = "/{rno}",
				produces = {MediaType.APPLICATION_XML_VALUE,
							MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyDTO> read(@PathVariable("rno") int rno){
		log.info("get : " + rno);
		
		return new ResponseEntity<ReplyDTO>(service.read(rno), HttpStatus.OK);
	}
	
	@PreAuthorize("principal.username == #rDto.replyer")
	@DeleteMapping(value = "/{rno}",
					consumes = "application/json",
					produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@RequestBody ReplyDTO rDto,
										 @PathVariable("rno") int rno){
		log.info("remove : " + rno);
		
		log.info("replyer : " + rDto.getReplyer());
		
		int delete = service.remove(rno);
		
		log.info("delete : " + delete);
		return delete == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PreAuthorize("principal.username == #rDto.replyer")
	@RequestMapping(value = "/{rno}",
					method = {RequestMethod.PUT, RequestMethod.PATCH},
					consumes = "application/json",
					produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@PathVariable("rno") int rno,
										 @RequestBody ReplyDTO rDto) {
		rDto.setRno(rno);
		
		log.info("rno : " + rno);
		log.info("modify : " + rDto);
		return service.modify(rDto) == 1
					? new ResponseEntity<String>("succes", HttpStatus.OK)
					: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
