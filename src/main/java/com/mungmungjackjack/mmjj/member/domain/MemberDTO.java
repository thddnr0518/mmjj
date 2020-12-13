package com.mungmungjackjack.mmjj.member.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MemberDTO {

	private String userid;
	private String userpw;
	private String nickName;
	private String email;
	private String userName;
	private String birth;
	private String gender;
	private String zipNum;
	private String addr;
	private String phone;
	private String userYN;
	private boolean enabled;
	
	private Date regDate;
	private Date updateDate;
	private List<AuthDTO> authList;
}
