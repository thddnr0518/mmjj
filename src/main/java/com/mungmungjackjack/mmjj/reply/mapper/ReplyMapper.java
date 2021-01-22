package com.mungmungjackjack.mmjj.reply.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.reply.domain.ReplyDTO;

public interface ReplyMapper {
	public int insert(ReplyDTO replyDto);
	public int delete(int rno);
	public int update(ReplyDTO reply);

	public ReplyDTO read(int rno);
	
	public List<ReplyDTO> getListWithPaging(
			@Param("cri") Criteria cri, 
			@Param("bno") int bno);
	
	public int getCountByBno(int bno);
}
