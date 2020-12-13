package com.mungmungjackjack.mmjj.board.mapper;

import java.util.List;

import com.mungmungjackjack.mmjj.board.domain.BoardAttachDTO;

public interface BoardAttachMapper {

	public void insert(BoardAttachDTO boardAttachDto);
	public void deleteAll(int bno);
	public List<BoardAttachDTO> findByBno(int bno);
	public void delete(String uuid);
	
	public List<BoardAttachDTO> getOldFiles();
}
