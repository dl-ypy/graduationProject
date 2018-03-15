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
	public List queryStudent(String text, String sortname, String sortvalue, Integer tid) {
		return studentMapper.queryStudent(text,sortname,sortvalue, tid);
	}
	@Override
	public int queryIsStudent(int sid, String spassword) {
		return studentMapper.queryIsStudent(sid, spassword);
	}
	@Override
	public int updateStudent(Student student) {
		return studentMapper.updateStudent(student);
	}
	@Override
	public int isExist(int sid, int tid) {
		return studentMapper.isExits(sid, tid);
	}
}
