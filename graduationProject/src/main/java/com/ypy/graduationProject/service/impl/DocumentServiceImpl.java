package com.ypy.graduationProject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ypy.graduationProject.mapper.DocumentMapper;
import com.ypy.graduationProject.pojo.Document;
import com.ypy.graduationProject.service.IDocumentService;

@Service
public class DocumentServiceImpl implements IDocumentService {
	@Autowired
	private DocumentMapper documentMapper;

	@Override
	public List queryDocument(String text, String isApprove, Integer tid) {
		return documentMapper.queryDocument(text, isApprove, tid);
	}

	@Override
	public int queryByIdAndTid(int id, int tid) {
		return documentMapper.queryByIdAndTid(id, tid);
	}

	@Override
	public int updateDocument(Document document) {
		return documentMapper.updateDocument(document);
	}

	@Override
	public Document queryOneDocument(int id) {
		return documentMapper.queryOneDocument(id);
	}

	@Override
	public List queryDocumentBySid(int sid) {
		return documentMapper.queryDocumentBySid(sid);
	}

	@Override
	public Document isExsit(int sid, String realFileName) {
		return documentMapper.isExsit(sid, realFileName);
	}

	@Override
	public int addDocument(Document doc) {
		return documentMapper.addDocument(doc);
	}
	
}
