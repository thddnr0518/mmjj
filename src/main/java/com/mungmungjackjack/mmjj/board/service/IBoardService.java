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
	// 최근 한달 인기글
	public List<BoardRankDTO> rank() throws Exception;
	// 그달의 인기글
	public List<BoardRankDTO> monthRank() throws Exception;
	// 글 수정
	public boolean modify(BoardDTO bDto) throws Exception;
	// 글 삭제
	public boolean remove(Integer bno) throws Exception;
	// 조회수 상승
	public void updateViewCnt(Integer bno) throws Exception;
	// 댓글 수
	public void updateReplyCnt(Map<String, Object> update) throws Exception;
	// 미리보기
	public List<BoardAttachDTO> getAttachList(int bno);
}
