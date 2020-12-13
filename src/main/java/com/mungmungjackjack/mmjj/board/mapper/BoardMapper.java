package com.mungmungjackjack.mmjj.board.mapper;

import java.util.List;
import java.util.Map;

import com.mungmungjackjack.mmjj.board.domain.BoardDTO;
import com.mungmungjackjack.mmjj.board.domain.BoardRankDTO;
import com.mungmungjackjack.mmjj.board.domain.Criteria;

public interface BoardMapper {

	public List<BoardDTO> getListWithPaging(Criteria cri) throws Exception;
	public int getTotalCnt(Criteria cri) throws Exception;
	public void create(BoardDTO bDto) throws Exception;
	public void updateViewCnt(Integer bno) throws Exception;
	public BoardDTO read(Integer bno) throws Exception;
	public int update(BoardDTO bDto) throws Exception;
	public int delete(Integer bno) throws Exception;
	
	public void updateReplyCnt(Map<String, Object> update) throws Exception;
	
	public List<BoardRankDTO> rank() throws Exception;
}
