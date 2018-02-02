package com.ypy.graduationProject.service;

import java.util.List;

public interface IStudentService {
	List queryStudent(String text);
	int queryIsStudent(int sid, String spassword);
}
