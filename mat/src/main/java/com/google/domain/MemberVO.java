package com.google.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String userId;
	private String userPw;
	private String userName;
	private Date regDate;
	private Date updateDate;
	private boolean enabled;
	private List<AuthVO> authList;
}
