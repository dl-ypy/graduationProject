package com.ypy.graduationProject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ypy.graduationProject.mapper.StudentMapper;
import com.ypy.graduationProject.pojo.Student;
import com.ypy.graduationProject.service.IStudentService;

@Service
public class StudentServiceImpl implements IStudentService {
	@Autowired
	private StudentMapper studentMapper;
	@Override
	public List queryStudent() {
		return studentMapper.queryStudent();
	}
}
