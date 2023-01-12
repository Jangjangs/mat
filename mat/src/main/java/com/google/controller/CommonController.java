package com.google.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommonController {

	//Authentication 객체는 스프링 시큐리티에서 제공하는 사용자의 정보를 담고있는 객체다 (아이디, 권한 등)
    //필요한 경우 사용자의 정보를 화면에 보여주기 위해 파라미터로 받았다.
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		model.addAttribute("msg","Access Denied");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model){

	    if(error != null){
	    	model.addAttribute("error", "로그인 에러: 계정을 확인하십쇼.");
	    }
	    if(logout != null){
	    	model.addAttribute("logout", "로그아웃됨");
	    }
	}
	
	@GetMapping("/customLogout")
	public void customLogout() {
		
	}
}
