package com.ypy.graduationProject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ypy.graduationProject.mapper.TeacherMapper;
import com.ypy.graduationProject.pojo.Teacher;
import com.ypy.graduationProject.service.ITeacherService;

@Service
public class TeacherServiceImpl implements ITeacherService {
	@Autowired
	private TeacherMapper teacherMapper;
	@Override
	public List queryTeacher(int count) {
		return teacherMapper.queryTeacher(count);
	}
	@Override
	public Teacher queryIsTeacher(int tid, String tpassword) {
		return teacherMapper.queryIsTeacher(tid, tpassword);
	}
	@Override
	public int updateTeacher(Teacher teacher) {
		return teacherMapper.updateTeacher(teacher);
	}
}
