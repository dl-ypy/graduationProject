package com.ypy.graduationProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.ypy.graduationProject.service.IStudentService;

@Controller
@RequestMapping("/student")
public class StudentController {
	@Autowired
	private IStudentService iStudentService;
	
	@RequestMapping("/query")
	public void query() {
		if (iStudentService.query() != null) {
			System.out.println(iStudentService.query());
		}
	}
}
