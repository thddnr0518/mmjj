package com.mungmungjackjack.mmjj.board.domain;

import java.util.List;

import lombok.Data;

@Data
public class BoardRankDTO {

	private int viewcnt;
	private String title;
	private Integer bno;
	private String writer;
	private String uuid;
	private String uploadPath;
	private String fileName;
	
	private String imgSrc = "\\resources\\fileUpload\\";
	
	private List<BoardRankDTO> rankList;
}
