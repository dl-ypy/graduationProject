package com.ypy.graduationProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ypy.graduationProject.pojo.Title;

@Mapper
public interface TitleMapper {
	List queryTitle(@Param("text") String text, @Param("tid") Integer tid);
	List queryAllTitle(String text);
	int isSelected(@Param("cid") int cid);
	int updateTitle(Title title);
}
