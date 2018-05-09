package com.ypy.graduationProject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ypy.graduationProject.mapper.StudentMapper;
import com.ypy.graduationProject.pojo.Student;
import com.ypy.graduationProject.service.IStudentService;

@Service
@Transactional //添加事务
public class StudentServiceImpl implements IStudentService {
	@Autowired
	private StudentMapper studentMapper;
	@Override
	public List queryStudent(String text, String sortname, String sortvalue, Integer tid) {
		return studentMapper.queryStudent(text,sortname,sortvalue, tid);
	}
	@Override
	public Student queryIsStudent(int sid, String spassword) {
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
	@Override
	public Student queryOneStudent(int sid) {
		return studentMapper.queryOneStudent(sid);
	}
	@Override
	public int updateMStudent(Student student) {
		return studentMapper.updateMStudent(student);
	}
	@Override
	public int isSelected(int sid) {
		return studentMapper.isSelected(sid);
	}
	@Override
	public int isSelectedByCidAndSid(int sid, int cid) {
		return studentMapper.isSelectedByCidAndSid(sid, cid);
	}
}
