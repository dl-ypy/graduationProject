package com.ypy.graduationProject.service;

import java.util.List;

import com.ypy.graduationProject.pojo.Student;

public interface IStudentService {
	List queryStudent(String text);
	List queryMyStudent(String text, Integer tid);
	int queryIsStudent(int sid, String spassword);
	int updateStudent(Student student);
	int isExist(int sid, int tid);
}
