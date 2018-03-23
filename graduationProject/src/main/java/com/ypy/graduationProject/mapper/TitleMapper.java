package com.ypy.graduationProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface TitleMapper {
	List queryTitle(@Param("text") String text, @Param("tid") Integer tid);
}
