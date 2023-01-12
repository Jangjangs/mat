package com.google.mapper;

import com.google.domain.MemberVO;

public interface MemberMapper {

	public void signup(MemberVO vo);
	
	public MemberVO read(String userId);
	
}
