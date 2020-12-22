package com.mungmungjackjack.mmjj.member.service;

import com.mungmungjackjack.mmjj.member.domain.MemberDTO;

public interface IMemberService {
	public MemberDTO login(MemberDTO mDto);
	
	public String idChk(String id);
	public void insertMem(MemberDTO mDto);
	public void authMem(String userid);
	
	public String getTime();
	public MemberDTO selMember(String userid) throws Exception;
	public MemberDTO selLoginInfo(String userid, String userpw) throws Exception;
	
	public void deleteAuth();
	public void deleteMem();
}