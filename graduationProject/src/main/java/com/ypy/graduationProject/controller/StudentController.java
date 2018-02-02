package com.ypy.graduationProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ypy.graduationProject.common.ServerResponse;
import com.ypy.graduationProject.service.IStudentService;

@Controller
@RequestMapping("/student")
public class StudentController {
	@Autowired
	private IStudentService iStudentService;
	
	@RequestMapping("/queryStudent")
	@ResponseBody
	public Map queryStudent(@RequestParam(required=false) String text) {
		List studentList = iStudentService.queryStudent(text);
		System.err.println(studentList);
		Map map = new HashMap<>();
		map.put("rows", studentList);
		map.put("total", studentList.size());
		return map;
	}
}
