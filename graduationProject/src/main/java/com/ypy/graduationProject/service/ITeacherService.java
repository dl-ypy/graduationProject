package com.ypy.graduationProject.service;

import java.util.List;

import com.ypy.graduationProject.pojo.Teacher;

public interface ITeacherService {
	List queryTeacher(String text);
	Teacher queryIsTeacher(int tid, String tpassword);
	int updateTeacher(Teacher teacher);
}
