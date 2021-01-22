package com.mungmungjackjack.mmjj.board.service;

import java.util.List;
import java.util.Map;

import com.mungmungjackjack.mmjj.board.domain.BoardAttachDTO;
import com.mungmungjackjack.mmjj.board.domain.BoardDTO;
import com.mungmungjackjack.mmjj.board.domain.BoardRankDTO;
import com.mungmungjackjack.mmjj.domain.Criteria;

public interface IBoardService {
	// 게시판 목록
	public List<BoardDTO> listAll(Criteria cri) throws Exception;
	
	// 등록된 게시글 개수
	public int getTotalCnt(Criteria cri) throws Exception;
	
	// 게시판 글 작성
	public void register(BoardDTO bDto) throws Exception;
	
	// 글 상세
	public BoardDTO read(Integer bno) throws Exception;
	
	
	public boolean modify(BoardDTO bDto) throws Exception;
	public boolean remove(Integer bno) throws Exception;
	
	public void updateViewCnt(Integer bno) throws Exception;
	public void updateReplyCnt(Map<String, Object> update) throws Exception;
	
	public List<BoardAttachDTO> getAttachList(int bno);
	public List<BoardRankDTO> rank() throws Exception;
}
