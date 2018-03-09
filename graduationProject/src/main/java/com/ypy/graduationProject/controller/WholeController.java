package com.ypy.graduationProject.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ypy.graduationProject.common.Const;
import com.ypy.graduationProject.common.ServerResponse;
import com.ypy.graduationProject.service.IStudentService;
import com.ypy.graduationProject.service.ITeacherService;

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
	@Autowired
	private ITeacherService iTeacherService;
	
	/*
	 * 用户登录
	 */
	@RequestMapping("login")
	@ResponseBody
	public ServerResponse login(int type, int id, String password, HttpSession session) {
		if (type == 2) { //学生
			int count = iStudentService.queryIsStudent(id, password);
			if (count > 0) {
				session.setAttribute(Const.USER_STUDENT, id);
				return ServerResponse.createBySuccessMsg("back/student/studentPanel");
			} else {
				return ServerResponse.createByFailMsg("用户未注册或身份错误！");
			}
		} else if (type == 1) {  //教师
			int count = iTeacherService.queryIsTeacher(id, password);
			if (count > 0) {
				session.setAttribute(Const.USER_TEACHER, id);
				return ServerResponse.createBySuccessMsg("back/teacher/teacherPanel");
			} else {
				return ServerResponse.createByFailMsg("用户未注册或身份错误！");
			}
		} else if (type == 0) { //管理员
			session.setAttribute(Const.USER_ADMIN, id);
			return ServerResponse.createBySuccessMsg("back/admin/adminPanel");
		} else {
			return ServerResponse.createByFailMsg("无此类型用户！");
		}
	}
}
