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
public class MemberTest {

	@Autowired
	private PasswordEncoder pwen;
	
	@Autowired
	private MemberMapper mapper;
	
//	@Test
//	public void jointest() {
//		MemberDTO mDto = new MemberDTO();
//		mDto.setUserid("admin0");
//		mDto.setUserpw(pwen.encode("pw00"));
//		mDto.setNickName("admin");
//		mDto.setEmail("email@email.com");
//		mDto.setUserName("어드민");
//		mDto.setBirth("19950505");
//		mDto.setGender("M");
//		mDto.setZipNum("5050");
//		mDto.setAddr("한경빌딩");
//		mDto.setPhone("01010101010");
//		
//		mapper.insertMem(mDto);
//		mapper.addauth("admin0");
//		mapper.authMem("admin0");
//	}
	
	@Test
	public void idChkTest() {
		String id = "dkdkasd";
		boolean result = mapper.idChk(id) == null;
		
		log.info("result false는 중복, true는 사용가능 --> " + result);
	}
}
