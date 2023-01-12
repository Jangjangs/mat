package com.google.service;

import java.util.List;

import com.google.domain.BoardVO;
import com.google.domain.Criteria;

public interface BoardService {

	public List<BoardVO> getlist();
	
	public void insert(BoardVO vo);
	
	public BoardVO get(long bno);
	
	public boolean update(BoardVO vo);
	
	public void delete(long bno);
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int getListTotal(Criteria cri);
}
