package com.google.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.google.domain.BoardVO;
import com.google.domain.Criteria;

public interface FreeMapper {

	public List<BoardVO> getlist();
	
	public void insert(BoardVO vo);
	
	public long insertLastId(BoardVO vo);
	
	public BoardVO get(long bno);
	
	public boolean update(BoardVO vo);
	
	public void delete(long bno);
	
	public List<BoardVO> getListwithPaging(Criteria cri);
	
	public int getListTotal(Criteria cri);
	
	public void updateHit(long bno);
	
	public void updateReplyCnt(@Param("bno") long bno, @Param("amount") int amount);
}
