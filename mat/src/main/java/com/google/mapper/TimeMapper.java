package com.google.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {

	@Select("SELECT curdate()")
	public String getTime();
	
	public String getTime2();
	
	public String getMember();
}
