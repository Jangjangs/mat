package com.google.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/paldo/*")
public class PaldoController {

	@GetMapping("/gyeongbuk")
	public void gyeongbug() {
		
	}
	
	@GetMapping("/gyeonggi")
	public void gyeonggi() {
		
	}
	@GetMapping("/chungcheong")
	public void chungcheong() {
		
	}
	@GetMapping("/jeonla")
	public void jeonla() {
		
	}
}
