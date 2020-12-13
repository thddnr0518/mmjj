package com.mungmungjackjack.mmjj.member.mapper;

import com.mungmungjackjack.mmjj.member.domain.MemberDTO;

public interface MemberMapper {
	public MemberDTO login(MemberDTO mDto);
	
	public MemberDTO read(String userid);
	public int addauth(String userid);
	
	public void insertMem(MemberDTO mDto);
	public String idChk(String id);
	
	public void authMem(String userid);
	
	
	public String getTime();
	public MemberDTO selMember(String userid) throws Exception;
	public MemberDTO selLoginInfo(String userid, String userpw) throws Exception;
}
