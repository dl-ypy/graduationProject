package com.ypy.graduationProject.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ypy.graduationProject.common.Const;
import com.ypy.graduationProject.common.ServerResponse;
import com.ypy.graduationProject.pojo.Teacher;
import com.ypy.graduationProject.service.ITeacherService;

@Controller
@RequestMapping("/teacher")
public class TeacherController {
	@Autowired
	private ITeacherService iTeacherService;
	
	/**
	 * 查询一个教师
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryOneTeacher")
	@ResponseBody
	public ServerResponse queryOneTeacher(HttpSession session) {
		if (session.getAttribute(Const.USER_TEACHER) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			Teacher teacher = iTeacherService.queryIsTeacher((Integer)session.getAttribute(Const.USER_TEACHER), null);
			if (teacher != null) {
				return ServerResponse.createBySuccessData(teacher);
			} else {
				return ServerResponse.createByFailMsg("无该教师！");
			}
		}
	}
	
	/**
	 * 学生查询教师信息
	 * @param tid
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryOneTeacherByStu")
	@ResponseBody
	public ServerResponse queryOneTeacherByStu(int tid, HttpSession session) {
		if (session.getAttribute(Const.USER_NAME) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			Teacher teacher = iTeacherService.queryIsTeacher(tid, null);
			if (teacher != null) {
				return ServerResponse.createBySuccessData(teacher);
			} else {
				return ServerResponse.createByFailMsg("无该教师！");
			}
		}
	}
	
	/**
	 * 修改教师基本信息
	 * @param teacher
	 * @param session
	 * @return
	 */
	@RequestMapping("/updateTeacher")
	@ResponseBody
	public ServerResponse updateTeacher(Teacher teacher, HttpSession session) {
		if (session.getAttribute(Const.USER_TEACHER) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			int updateCount = iTeacherService.updateTeacher(teacher);
			if (updateCount > 0) {
				if (teacher.getTname() != null) {
					session.setAttribute(Const.USER_NAME, teacher.getTname());  //将session中的名字也进行修改
				}
				return ServerResponse.createBySuccessMsg("保存成功！");
			} else {
				return ServerResponse.createBySuccessMsg("保存失败！");
			}
		}
	}
	
	/**
	 * 修改密码
	 * @param oldPassword
	 * @param password
	 * @param tpassword
	 * @param session
	 * @return
	 */
	@RequestMapping("/updateTeacherPass")
	@ResponseBody
	public ServerResponse updateTeacherPass(String oldPassword, String password, String tpassword, HttpSession session) {
		if (session.getAttribute(Const.USER_TEACHER) == null) {
			return ServerResponse.createByFailMsg("请先登录！");
		} else {
			Teacher teacher = iTeacherService.queryIsTeacher((int) session.getAttribute(Const.USER_TEACHER), oldPassword);
			if (teacher == null) {
				return ServerResponse.createByFailMsg("原密码错误！");
			} else {
				Teacher t = new Teacher();
				t.setTid((int) session.getAttribute(Const.USER_TEACHER));
				t.setTpassword(tpassword);
				int updateCount = iTeacherService.updateTeacher(t);
				if (updateCount > 0) {
					return ServerResponse.createBySuccessMsg("修改成功！");
				} else {
					return ServerResponse.createBySuccessMsg("修改失败！");
				}
			}
		}
	}
	
	/**
	 * 修改后重新刷新欢迎姓名
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryTeacherUserName")
	@ResponseBody
	public ServerResponse queryTeacherUserName(HttpSession session) {
		if (session.getAttribute(Const.USER_TEACHER) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			return ServerResponse.createBySuccessMsg((String) session.getAttribute(Const.USER_NAME));
		}
	}
	
	@RequestMapping("/queryTeacher")
	@ResponseBody
	public ServerResponse queryTeacher(HttpSession session) {
		if (session.getAttribute(Const.USER_ADMIN) == null) {
			return ServerResponse.createByFailMsg("请已管理员身份登录！");
		} else {
			List teacherList = iTeacherService.queryTeacher(Const.TEACHER_TITLE_COUNT);
			if (teacherList != null) {
				return ServerResponse.createBySuccessData(teacherList);
			}
			return ServerResponse.createByFailMsg("无教师信息！");
		}
	}
	
}
