package com.mungmungjackjack.mmjj.reply.service;

import java.util.List;

import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.reply.domain.ReplyDTO;
import com.mungmungjackjack.mmjj.reply.domain.ReplyPageDTO;

public interface IReplyService {
	public int register(ReplyDTO replyDto);
	public ReplyDTO read(int rno);
	public int modify(ReplyDTO replyDto);
	
	public int remove(int rno);
	
	public List<ReplyDTO> getList(Criteria cri, int bno);
	
	public ReplyPageDTO getListPage(Criteria cri, int bno);
}
