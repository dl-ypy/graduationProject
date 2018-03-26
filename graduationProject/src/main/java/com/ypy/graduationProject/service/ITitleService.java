package com.ypy.graduationProject.service;

import java.util.List;

import com.ypy.graduationProject.pojo.Student;
import com.ypy.graduationProject.pojo.Title;

public interface ITitleService {
	List queryTitle(String text, Integer tid);
	List queryAllTitle(String text);
	int isSelected(int cid);
	int updateTitle(Title title);
}
