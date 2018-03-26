package com.ypy.graduationProject.service;

import java.util.List;

import com.ypy.graduationProject.pojo.Student;

public interface IStudentService {
	List queryStudent(String text, String sortname, String sortvalue, Integer tid);
	Student queryIsStudent(int sid, String spassword);
	int updateStudent(Student student);
	int isExist(int sid, int tid);
	Student queryOneStudent(int sid);
	int updateMStudent(Student student);
	int isSelected(int sid);
	int isSelectedByCidAndSid(int attribute, int cid);
}
