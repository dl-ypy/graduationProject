package com.ypy.graduationProject.service;

import java.util.List;

import com.ypy.graduationProject.pojo.Student;

public interface IDocumentService {
	List queryDocument(String text, Integer tid);
}
