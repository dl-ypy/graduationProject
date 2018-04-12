package com.ypy.graduationProject.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ypy.graduationProject.common.Const;
import com.ypy.graduationProject.common.ServerResponse;
import com.ypy.graduationProject.pojo.Admin;
import com.ypy.graduationProject.pojo.Student;
import com.ypy.graduationProject.pojo.Teacher;
import com.ypy.graduationProject.service.IStudentService;
import com.ypy.graduationProject.service.ITeacherService;
import com.ypy.graduationProject.service.IAdminService;

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
	@Autowired
	private IAdminService iAdminService;
	
	/*
	 * 用户登录
	 */
	@RequestMapping("login")
	@ResponseBody
	public ServerResponse login(int type, int id, String password, HttpSession session) {
		if (type == 2) { //学生
			//判断该学生是否存在
			Student student = iStudentService.queryIsStudent(id, password);
			if (student != null) {
				//如果存在  将id和姓名保存到session中
				session.setAttribute(Const.USER_STUDENT, id);
				session.setAttribute(Const.USER_NAME, student.getSname());
				return ServerResponse.createBySuccessMsg("back/student/studentPanel");
			} else {
				return ServerResponse.createByFailMsg("用户未注册或身份错误或密码错误！");
			}
		} else if (type == 1) {  //教师
			Teacher teacher = iTeacherService.queryIsTeacher(id, password);
			if (teacher != null) {
				session.setAttribute(Const.USER_TEACHER, id);
				session.setAttribute(Const.USER_NAME, teacher.getTname());
				return ServerResponse.createBySuccessMsg("back/teacher/teacherPanel");
			} else {
				return ServerResponse.createByFailMsg("用户未注册或身份错误或密码错误！");
			}
		} else if (type == 0) { //管理员
			Admin admin = iAdminService.queryIsAdmin(id, password);
			if (admin != null) {
				session.setAttribute(Const.USER_ADMIN, id);
				session.setAttribute(Const.USER_NAME, admin.getName());
				return ServerResponse.createBySuccessMsg("back/admin/adminPanel");
			} else {
				return ServerResponse.createByFailMsg("用户未注册或身份错误或密码错误！");
			}
		} else {
			return ServerResponse.createByFailMsg("无此类型用户！");
		}
	}
	
	/*
	 * 用户注销
	 */
	@RequestMapping("logout")
	@ResponseBody
	public ServerResponse logout(HttpSession session) {
		if (session.getAttribute(Const.USER_NAME) != null) {
			session.invalidate();  //关闭session
			return ServerResponse.createBySuccessMsg("back/backLogin");
		} else {
			return ServerResponse.createByFailMsg("已注销！");
		}
	}
}
