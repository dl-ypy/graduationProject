package com.ypy.graduationProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ypy.graduationProject.pojo.Student;
import com.ypy.graduationProject.pojo.Teacher;

@Mapper
public interface TeacherMapper {
	Teacher queryIsTeacher(@Param("tid") int tid, @Param("tpassword") String tpassword);
	int updateTeacher(Teacher teacher);
	List queryTeacher();
}
