package com.google.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.google.domain.MemberVO;
import com.google.mapper.MemberMapper;
import com.google.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailService implements UserDetailsService {

	@Setter(onMethod_= {@Autowired} )
	private MemberMapper membermapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.warn("load user by userName: "+ username);
		
		MemberVO vo = membermapper.read(username);
		
		log.warn("membermapper: "+vo);
		return vo == null? null: new CustomUser(vo);
	}

}
