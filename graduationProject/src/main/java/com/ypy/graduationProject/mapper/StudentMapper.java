package com.ypy.graduationProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ypy.graduationProject.pojo.Student;

@Mapper
public interface StudentMapper {
	List queryStudent();
}
