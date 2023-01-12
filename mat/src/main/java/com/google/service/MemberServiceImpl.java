package com.google.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.domain.MemberVO;
import com.google.mapper.AuthMapper;
import com.google.mapper.MemberMapper;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class MemberServiceImpl implements MemberService{

	private MemberMapper mapper; 
	private AuthMapper authmapper;
	
	
	@Override
	public void signup(MemberVO vo) {
		mapper.signup(vo);
		
		
	}

}
