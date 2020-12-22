package com.mungmungjackjack.mmjj.task;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.mungmungjackjack.mmjj.member.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class DeleteMember {

	@Autowired
	private MemberMapper mapper;
	
	@Scheduled(cron = "0 0 2 * * *")
	public void deleteMember() throws Exception{
		log.info("deleteMember...");
		mapper.deleteAuth();
		mapper.deleteMem();
	}
}
