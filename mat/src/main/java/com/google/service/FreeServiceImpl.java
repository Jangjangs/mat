package com.google.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.google.domain.BoardVO;
import com.google.domain.Criteria;
import com.google.mapper.BoardMapper;
import com.google.mapper.FreeMapper;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service	
public class FreeServiceImpl implements FreeService{

	private FreeMapper mapper;
	
	@Override
	public List<BoardVO> getlist() {
		
		return mapper.getlist();
	}

	@Override
	public void insert(BoardVO vo) {
		mapper.insertLastId(vo);
		
	}

	@Override
	public BoardVO get(long bno) {
		mapper.updateHit(bno);
		return mapper.get(bno);
	}

	@Override
	public boolean update(BoardVO vo) {
		return mapper.update(vo);
	}

	@Override
	public void delete(long bno) {

		mapper.delete(bno);
	}

	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {
		return mapper.getListwithPaging(cri);
	}

	@Override
	public int getListTotal(Criteria cri) {
		return mapper.getListTotal(cri);
	}

}
