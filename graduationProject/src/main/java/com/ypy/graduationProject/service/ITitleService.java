package com.ypy.graduationProject.service;

import java.util.List;

import com.ypy.graduationProject.pojo.Student;
import com.ypy.graduationProject.pojo.Title;

public interface ITitleService {
	List queryTitle(String text, String isSelected, Integer tid);
	List queryAllTitle(String text, String isSelected);
	int isSelected(int cid);
	int updateTitle(Title title);
	int addTitle(Title title);
	int deleteTitle(int cid);
}
