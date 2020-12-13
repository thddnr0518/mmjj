package com.mungmungjackjack.mmjj.board.domain;

import java.util.List;

import lombok.Data;

@Data
public class BoardAttachDTO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean filetype;
	private int bno;
	
	private int replycnt;
	private List<BoardAttachDTO> attachList;
}
