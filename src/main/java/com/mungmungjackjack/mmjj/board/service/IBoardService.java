package com.mungmungjackjack.mmjj.board.service;

import java.util.List;
import java.util.Map;

import com.mungmungjackjack.mmjj.board.domain.BoardAttachDTO;
import com.mungmungjackjack.mmjj.board.domain.BoardDTO;
import com.mungmungjackjack.mmjj.board.domain.BoardRankDTO;
import com.mungmungjackjack.mmjj.board.domain.Criteria;

public interface IBoardService {
	public List<BoardDTO> listAll(Criteria cri) throws Exception;
	public int getTotalCnt(Criteria cri) throws Exception;
	public void register(BoardDTO bDto) throws Exception;
	public BoardDTO read(Integer bno) throws Exception;
	public boolean modify(BoardDTO bDto) throws Exception;
	public boolean remove(Integer bno) throws Exception;
	
	public void updateViewCnt(Integer bno) throws Exception;
	public void updateReplyCnt(Map<String, Object> update) throws Exception;
	
	public List<BoardAttachDTO> getAttachList(int bno);
	public List<BoardRankDTO> rank() throws Exception;
}
