package com.mungmungjackjack.mmjj.member.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mungmungjackjack.mmjj.member.domain.MemberDTO;
import com.mungmungjackjack.mmjj.member.mapper.MemberMapper;
import com.mungmungjackjack.mmjj.member.service.IMemberService;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements IMemberService{

	@Autowired
	private MemberMapper mapper;
	
	@Override
	public MemberDTO login(MemberDTO mDto) {
		return mapper.login(mDto);
	}
	
	@Override
	public void insertMem(MemberDTO mDto) {
		mapper.insertMem(mDto);
	}

	@Override
	public String getTime() {
		return mapper.getTime();
	}

	@Override
	public MemberDTO selMember(String userid) throws Exception {
		return mapper.selMember(userid);
	}

	@Override
	public MemberDTO selLoginInfo(String userid, String userpw) throws Exception {

		return mapper.selLoginInfo(userid, userpw);
	}

	@Override
	public String idChk(String id) {
		log.info("inputID -->>" + id);
		
		return mapper.idChk(id);
	}

	@Override
	public void authMem(String userid) {
		
		mapper.authMem(userid);
	}

	@Override
	public void deleteAuth() {
		mapper.deleteAuth();
		
	}

	@Override
	public void deleteMem() {
		mapper.deleteMem();
		
	}

}
