package com.ypy.graduationProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ypy.graduationProject.service.IStudentService;

@Controller
@RequestMapping("/student")
public class StudentController {
	@Autowired
	private IStudentService iStudentService;
	
	@RequestMapping("/queryStudent")
	public String queryStudent(Model model) {
		List studentList = iStudentService.queryStudent();
		System.err.println(studentList);
		model.addAttribute("studentList", studentList);
		return "back/student/studentTable";
	}
	
	@RequestMapping("/studentLogin")
	public String studentLogin(Model model) {
		return "back/backLogin";
	}
}
