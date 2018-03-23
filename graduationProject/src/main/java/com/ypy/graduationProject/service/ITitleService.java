package com.ypy.graduationProject.service;

import java.util.List;

import com.ypy.graduationProject.pojo.Student;

public interface ITitleService {
	List queryTitle(String text, Integer tid);
}
