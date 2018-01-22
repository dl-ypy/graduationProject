package com.ypy.graduationProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ypy.graduationProject.common.Const;
import com.ypy.graduationProject.common.ServerResponse;
import com.ypy.graduationProject.service.IStudentService;

/**
 * 整体公用的控制层
 * @author ypy
 */
@Controller
@RequestMapping("/whole")
@ResponseBody
public class WholeController {
	@Autowired
	private IStudentService iStudentService;
	
	/*
	 * 用户登录
	 */
	@RequestMapping("login")
	@ResponseBody
	public ServerResponse login(int type) {
		Map map = new HashMap<>();
		if (type == 2) {
			System.err.println("学生");
		} else if (type == 1) {
			System.err.println("教师");
			List studentList = iStudentService.queryStudent();
			map.put("studentList", studentList);
		} else if (type == 0) {
			System.err.println("管理员");
		}
		return ServerResponse.createBySuccessMsg("back/student/studentTable");
	}
}
