package com.mungmungjackjack.mmjj.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.mungmungjackjack.mmjj.member.domain.MemberDTO;
import com.mungmungjackjack.mmjj.member.mapper.MemberMapper;
import com.mungmungjackjack.mmjj.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		log.info("Load User By UserName : " + userName);
		
		MemberDTO mDto = mapper.read(userName);
		
		log.info("queried by member mapper : " + mDto);
		return mDto == null ? null : new CustomUser(mDto);
	}
}
