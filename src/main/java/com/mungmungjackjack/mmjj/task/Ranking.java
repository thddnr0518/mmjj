package com.mungmungjackjack.mmjj.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mungmungjackjack.mmjj.board.mapper.BoardAttachMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class Ranking {

	@Autowired
	private BoardAttachMapper attachMapper;
	
	
}
