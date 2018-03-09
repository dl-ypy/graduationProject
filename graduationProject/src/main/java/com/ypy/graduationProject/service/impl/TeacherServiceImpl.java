package com.ypy.graduationProject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ypy.graduationProject.mapper.StudentMapper;
import com.ypy.graduationProject.mapper.TeacherMapper;
import com.ypy.graduationProject.service.ITeacherService;

@Service
public class TeacherServiceImpl implements ITeacherService {
	@Autowired
	private TeacherMapper teacherMapper;
	@Override
	public List queryTeacher(String text) {
		return teacherMapper.queryTeacher(text);
	}
	@Override
	public int queryIsTeacher(int tid, String tpassword) {
		return teacherMapper.queryIsTeacher(tid, tpassword);
	}
}
