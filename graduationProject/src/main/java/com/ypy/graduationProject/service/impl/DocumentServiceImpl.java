package com.ypy.graduationProject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ypy.graduationProject.mapper.DocumentMapper;
import com.ypy.graduationProject.service.IDocumentService;

@Service
public class DocumentServiceImpl implements IDocumentService {
	@Autowired
	private DocumentMapper documentMapper;

	@Override
	public List queryDocument(String text, Integer tid) {
		return documentMapper.queryDocument(text, tid);
	}
	
}
