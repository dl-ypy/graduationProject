package com.ypy.graduationProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ypy.graduationProject.pojo.Student;

@Mapper
public interface StudentMapper {
	List queryStudent(@Param("text") String text);
	int queryIsStudent(@Param("sid") int sid, @Param("spassword") String spassword);
}
