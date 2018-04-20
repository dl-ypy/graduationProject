package com.ypy.graduationProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ypy.graduationProject.pojo.Title;

@Mapper
public interface TitleMapper {
	List queryTitle(@Param("text") String text, @Param("isSelected") String isSelected, @Param("tid") Integer tid);
	List queryAllTitle(@Param("text") String text, @Param("isSelected") String isSelected);
	int isSelected(@Param("cid") int cid);
	int updateTitle(Title title);
	int addTitle(Title title);
	int deleteTitle(@Param("cid") int cid);
	List queryMyTitle(@Param("sid") int sid);
	String queryStuTitle(@Param("sid") int sid);
}
