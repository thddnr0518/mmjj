package com.mungmungjackjack.mmjj.board.mapper;

import java.util.List;
import java.util.Map;

import com.mungmungjackjack.mmjj.board.domain.BoardDTO;
import com.mungmungjackjack.mmjj.board.domain.BoardRankDTO;
import com.mungmungjackjack.mmjj.domain.Criteria;

public interface BoardMapper {

	// 게시판 목록
	public List<BoardDTO> getListWithPaging(Criteria cri) throws Exception;
	// 게시글 개수
	public int getTotalCnt(Criteria cri) throws Exception;
	// 게시글 등록
	public void create(BoardDTO bDto) throws Exception;
	// 조회수 상승
	public void updateViewCnt(Integer bno) throws Exception;
	// 게시글 상세
	public BoardDTO read(Integer bno) throws Exception;
	// 게시글 수정
	public int update(BoardDTO bDto) throws Exception;
	// 게시글 삭제
	public int delete(Integer bno) throws Exception;
	// 댓글 수
	public void updateReplyCnt(Map<String, Object> update) throws Exception;
	// 최근 한달 인기글
	public List<BoardRankDTO> rank() throws Exception;
	// 이달의 인기글
	public List<BoardRankDTO> monthRank() throws Exception;
}
