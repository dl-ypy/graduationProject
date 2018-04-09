package com.ypy.graduationProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ypy.graduationProject.pojo.Document;

@Mapper
public interface DocumentMapper {
	List queryDocument(@Param("text") String text, @Param("isApprove") String isApprove, @Param("tid") Integer tid);
	int queryByIdAndTid(@Param("id") int id, @Param("tid") int tid);
	int updateDocument(Document document);
	Document queryOneDocument(@Param("id") int id);
	List queryDocumentBySid(@Param("sid") int sid);
	Document isExsit(@Param("sid") int sid, @Param("dname") String realFileName);
	int addDocument(Document doc);
}
