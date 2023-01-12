package com.google.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Criteria {

	private int pageNum; //현재 페이지
	private int amount; //보여줄 데이터 갯수
	
	private String type; //검색조건
	private String keyword; //검색어
	
	public Criteria() {
		this(1,10);
	}

	
	public Criteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public int getSkip() {
		return (this.pageNum-1)*this.amount;
	}
	
	public String[] getTypeArr() {
		return type == null?new String[] {}:type.split("");
		//TC면 T C 각각 잘라 배열로 만듦
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.getPageNum())
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}
}
