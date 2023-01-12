package com.google.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.domain.MemberVO;
import com.google.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Controller
@AllArgsConstructor
@RequestMapping("/member/*")
public class MemberController {
	
	@Setter(onMethod_= {@Autowired} )
	private BCryptPasswordEncoder bcrptPasswordEncoder;
	private MemberService service;
	
	@GetMapping("/signup")
	public void signup() {
		
	}
	
	@PostMapping("/signup")
	public String signup(MemberVO vo) {
		
		String rawPw = "";
		String encodePw = "";
		
		rawPw = vo.getUserPw();
		encodePw = bcrptPasswordEncoder.encode(rawPw);
		vo.setUserPw(encodePw);
		
		//회원가입
		service.signup(vo);
		return "redirect:/customLogin";
	}

}
