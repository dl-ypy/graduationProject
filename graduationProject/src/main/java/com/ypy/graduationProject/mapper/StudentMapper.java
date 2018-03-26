package com.ypy.graduationProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ypy.graduationProject.pojo.Student;

@Mapper
public interface StudentMapper {
	List queryStudent(@Param("text") String text, @Param("sortname") String sortname, @Param("sortvalue") String sortvalue, @Param("tid") Integer tid);
	Student queryIsStudent(@Param("sid") int sid, @Param("spassword") String spassword);
	int updateStudent(Student student);
	int isExits(@Param("sid") int sid, @Param("tid") int tid);
	Student queryOneStudent(@Param("sid") int sid);
	int updateMStudent(Student student);
	int isSelected(@Param("sid") int sid);
	int isSelectedByCidAndSid(@Param("sid") int sid, @Param("cid") int cid);
}
