package com.google.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.domain.BoardVO;
import com.google.domain.Criteria;
import com.google.domain.PageDTO;
import com.google.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping("/notice/*")
public class BoardController {

	private BoardService service;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		model.addAttribute("list", service.getListWithPaging(cri));
		int total = service.getListTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(total, cri));
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/insert")
	public void insert() {
		
	}
	
	@PostMapping("/insert")
	public String insert(BoardVO vo) {
		service.insert(vo);
		
		return "redirect:/notice/list";
	}
	
	@GetMapping({"/get", "/update"})
	public void get(@RequestParam("bno") long bno, Model model, Criteria cri) {
		model.addAttribute("board", service.get(bno));
		model.addAttribute("pageMaker", new PageDTO(cri));
	}
	
	@PostMapping("/update")
	public String update(BoardVO vo, RedirectAttributes rttr, Criteria cri) {
		service.update(vo);
		
		rttr.addFlashAttribute("result", vo.getBno());
		return "redirect:/notice/get"+cri.getListLink()+"&bno="+vo.getBno();
		//?pageNum="+cri.getPageNum()+"&amount="+cri.getAmount()+"&bno="+vo.getBno()
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam("bno") long bno) {
		service.delete(bno);
		return "redirect:/notice/list";
		
	}
	
}
