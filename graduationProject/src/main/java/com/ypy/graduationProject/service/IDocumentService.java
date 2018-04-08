package com.ypy.graduationProject.service;

import java.util.List;
import com.ypy.graduationProject.pojo.Document;

public interface IDocumentService {
	List queryDocument(String text, String isApprove, Integer tid);
	int queryByIdAndTid(int id, int attribute);
	int updateDocument(Document document);
	Document queryOneDocument(int id);
}
