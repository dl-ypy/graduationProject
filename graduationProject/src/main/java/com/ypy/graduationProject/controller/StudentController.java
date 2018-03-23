package com.ypy.graduationProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ypy.graduationProject.common.Const;
import com.ypy.graduationProject.common.ServerResponse;
import com.ypy.graduationProject.pojo.Student;
import com.ypy.graduationProject.service.IStudentService;

@Controller
@RequestMapping("/student")
public class StudentController {
	@Autowired
	private IStudentService iStudentService;
	
	/**
	 * 按条件分页查询学生信息
	 * @param text 学号或姓名
	 * @param flag 判断是否为自己的学生
	 * @param sortname 排序的字段
	 * @param sortvalue 升序或降序
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryStudent")
	@ResponseBody
	public ServerResponse queryStudent(@RequestParam(required=false) String text, @RequestParam(required=false) String flag,
			@RequestParam(required=false) String sortname, @RequestParam(required=false) String sortvalue,
			HttpSession session) {
		if (session.getAttribute(Const.USER_NAME) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			if (Const.USER_ADMIN==null && Const.USER_TEACHER==null) {
				return ServerResponse.createByFailMsg("请以教师或管理员身份登录！");
			} else {
				List studentList = null;
				if ("0".equals(flag)) {
					studentList = iStudentService.queryStudent(text,sortname,sortvalue,-1);
				} else {
					studentList = iStudentService.queryStudent(text,sortname,sortvalue,(Integer)session.getAttribute(Const.USER_TEACHER));
				}
				//easyui的分页需要
				return ServerResponse.createBySuccessPage(studentList, studentList.size());
			}
		}
	}
	
	/**
	 * 修改学生信息
	 * @param student
	 * @param session
	 * @return
	 */
	@RequestMapping("/updateStudent")
	@ResponseBody
	public ServerResponse updateStudent(Student student, HttpSession session) {
		if (session.getAttribute(Const.USER_TEACHER) == null) {
			return ServerResponse.createByFailMsg("请先登录！");
		}
		int tid = (Integer) session.getAttribute(Const.USER_TEACHER);
		int count = iStudentService.isExist(student.getSid(), tid);
		if (count > 0) {
			int updateResult = iStudentService.updateStudent(student);
			if (updateResult > 0) {
				return ServerResponse.createBySuccessMsg("修改成功！");
			} else {
				return ServerResponse.createByFailMsg("修改失败！");
			}
		} else {
			return ServerResponse.createByFailMsg("您没有权限修改学号为:"+student.getSid()+"的学生成绩，请点击我的学生按钮！");
		}
	}
}
