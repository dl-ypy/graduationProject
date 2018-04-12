package com.ypy.graduationProject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ypy.graduationProject.mapper.StudentMapper;
import com.ypy.graduationProject.mapper.TitleMapper;
import com.ypy.graduationProject.pojo.Student;
import com.ypy.graduationProject.pojo.Title;
import com.ypy.graduationProject.service.IStudentService;
import com.ypy.graduationProject.service.ITitleService;

@Service
public class TitleServiceImpl implements ITitleService {
	@Autowired
	private TitleMapper titleMapper;

	@Override
	public List queryTitle(String text, String isSelected, Integer tid) {
		return titleMapper.queryTitle(text, isSelected, tid);
	}

	@Override
	public List queryAllTitle(String text, String isSelected) {
		return titleMapper.queryAllTitle(text, isSelected);
	}

	@Override
	public int isSelected(int cid) {
		return titleMapper.isSelected(cid);
	}

	@Override
	public int updateTitle(Title title) {
		return titleMapper.updateTitle(title);
	}

	@Override
	public int addTitle(Title title) {
		return titleMapper.addTitle(title);
	}

	@Override
	public int deleteTitle(int cid) {
		return titleMapper.deleteTitle(cid);
	}
	
}
