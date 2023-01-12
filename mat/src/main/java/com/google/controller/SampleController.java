package com.google.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/sample/*")
@Controller
public class SampleController {

	@GetMapping("/all")
	public void all() {
		System.out.println("모든 사람 접근 가능");
	}
	
	@GetMapping("/member")
	public void member() {
		System.out.println("멤버만 접근 가능");
	}
	
	@GetMapping("/admin")
	public void admin() {
		System.out.println("관리자만 접근 가능");
	}
}
