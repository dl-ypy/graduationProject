package com.ypy.graduationProject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ypy.graduationProject.mapper.StudentMapper;
import com.ypy.graduationProject.mapper.TitleMapper;
import com.ypy.graduationProject.pojo.Student;
import com.ypy.graduationProject.service.IStudentService;
import com.ypy.graduationProject.service.ITitleService;

@Service
public class TitleServiceImpl implements ITitleService {
	@Autowired
	private TitleMapper titleMapper;

	@Override
	public List queryTitle(String text, Integer tid) {
		return titleMapper.queryTitle(text, tid);
	}
	
}