package com.mungmungjackjack.mmjj;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mungmungjackjack.mmjj.member.domain.MemberDTO;
import com.mungmungjackjack.mmjj.member.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
					"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemTest {

	@Autowired
	private MemberMapper mapper;
	
	@Test
	public void deleteMemTest() {
		mapper.deleteAuth();
		mapper.deleteMem();
	}
}
