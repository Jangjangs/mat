package com.google.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.domain.GbVO;
import com.google.mapper.RestapiMapper;

import lombok.Setter;

@Service
public class RestapiServiceImpl implements RestapiService {

	@Setter(onMethod_= {@Autowired} )
	private RestapiMapper mapper;
	
	@Override
	public int insert(GbVO vo) {

		return mapper.insert(vo);
	}

}
