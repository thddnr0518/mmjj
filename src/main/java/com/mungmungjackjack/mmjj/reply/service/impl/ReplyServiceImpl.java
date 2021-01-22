package com.mungmungjackjack.mmjj.reply.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mungmungjackjack.mmjj.board.service.IBoardService;
import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.reply.domain.ReplyDTO;
import com.mungmungjackjack.mmjj.reply.domain.ReplyPageDTO;
import com.mungmungjackjack.mmjj.reply.mapper.ReplyMapper;
import com.mungmungjackjack.mmjj.reply.service.IReplyService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements IReplyService{

	@Autowired
	private ReplyMapper mapper;
	
	@Autowired
	private IBoardService service;
	
	@Transactional
	@Override
	public int register(ReplyDTO replyDto) {
		log.info("Reply register .........." + replyDto);
		
		Map<String, Object> update = new HashMap<String, Object>();
		update.put("bno", replyDto.getBno());
		update.put("amount", +1);
		
		try {
			service.updateReplyCnt(update);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapper.insert(replyDto);
	}

	@Override
	public ReplyDTO read(int rno) {
		log.info("read................." + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyDTO replyDto) {
		log.info("Modify ................." + replyDto);
		return mapper.update(replyDto);
	}

	@Transactional
	@Override
	public int remove(int rno) {
		log.info("Delete..............." + rno);
		ReplyDTO replyDto = mapper.read(rno);
		
		Map<String, Object> update = new HashMap<String, Object>();
		update.put("bno", replyDto.getBno());
		update.put("amount", -1);
		
		try {
			service.updateReplyCnt(update);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyDTO> getList(Criteria cri, int bno) {
		log.info("getList..........." + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, int bno) {
		log.info("getListPage..........." + bno);
		return new ReplyPageDTO(
				mapper.getCountByBno(bno),
				mapper.getListWithPaging(cri, bno));
	}

}
