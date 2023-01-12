package com.google.service;

import com.google.domain.Criteria;
import com.google.domain.ReplyPageDTO;
import com.google.domain.ReplyVO;

public interface ReplyService {

	public int insert(ReplyVO vo);
	
	public ReplyPageDTO getListWithPaging(Criteria cri, long bno);
	
	public int update(ReplyVO vo);
	
	public int delete(long rno);
}
