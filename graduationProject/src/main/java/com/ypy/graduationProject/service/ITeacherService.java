package com.ypy.graduationProject.service;

import java.util.List;

public interface ITeacherService {
	List queryTeacher(String text);
	int queryIsTeacher(int tid, String tpassword);
}
