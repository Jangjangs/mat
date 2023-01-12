package com.google.security;

import org.springframework.security.crypto.password.PasswordEncoder;

public class CustomNoOpPasswordEncoder implements PasswordEncoder {

	@Override
	//인코딩하는 메소드 
	public String encode(CharSequence rawPassword) {
		// TODO Auto-generated method stub
		return rawPassword.toString();
	}

	@Override
	//요청받은 패스워드가 인코딩된 패스워드와 일치하는지 확인하는 메서드
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		//패스워드를 인코딩 없이 저장했기때문에 문자열들을 그대로 비교
		return rawPassword.toString().equals(encodedPassword);
	}
	

}
