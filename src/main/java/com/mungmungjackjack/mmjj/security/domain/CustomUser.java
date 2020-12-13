package com.mungmungjackjack.mmjj.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.mungmungjackjack.mmjj.member.domain.MemberDTO;

import lombok.Getter;
import lombok.extern.log4j.Log4j;

@Log4j
@Getter
public class CustomUser extends User{

	private static final long serialVersionUID = 1L;
	private MemberDTO member;
	
	private ResponseEntity<MemberDTO> response;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		
		log.info("CustomUser1");
	}
	
	public CustomUser(MemberDTO mDto) {
		super(mDto.getUserid(), mDto.getUserpw(), mDto.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		log.info("CustomUser2");
		this.member = mDto;
	}
}
