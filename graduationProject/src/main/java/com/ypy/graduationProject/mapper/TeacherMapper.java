package com.ypy.graduationProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ypy.graduationProject.pojo.Student;

@Mapper
public interface TeacherMapper {
	List queryTeacher(@Param("text") String text);
	int queryIsTeacher(@Param("tid") int tid, @Param("tpassword") String tpassword);
}
