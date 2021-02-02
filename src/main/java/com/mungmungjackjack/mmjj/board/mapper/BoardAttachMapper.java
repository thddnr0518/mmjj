package com.mungmungjackjack.mmjj.board.mapper;

import java.util.List;

import com.mungmungjackjack.mmjj.board.domain.BoardAttachDTO;

public interface BoardAttachMapper {
	// 파일첨부
	public void insert(BoardAttachDTO boardAttachDto);
	// 파일 전부 삭제
	public void deleteAll(int bno);
	// 해당 글번호의 파일들
	public List<BoardAttachDTO> findByBno(int bno);
	// 파일 삭제
	public void delete(String uuid);
	// 오래된 파일
	public List<BoardAttachDTO> getOldFiles();
}
