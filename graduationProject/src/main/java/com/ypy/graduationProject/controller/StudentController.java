package com.ypy.graduationProject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	 * @param text
	 * @return
	 */
	@RequestMapping("/queryStudent")
	@ResponseBody
	public Map queryStudent(HttpSession session, @RequestParam(required=false) String text) {
		List studentList = iStudentService.queryStudent(text);
		Map map = new HashMap<>();
		//easyui的分页需要
		map.put("rows", studentList);
		map.put("total", studentList.size());
		return map;
	}
	
	/**
	 * 按条件分页查询教师自己的学生信息
	 * @param text
	 * @return
	 */
	@RequestMapping("/queryMyStudent")
	@ResponseBody
	public Map queryMyStudent(@RequestParam(required=false) String text, HttpSession session) {
		System.err.println(session.getAttribute(Const.USER_TEACHER));
		List studentList = iStudentService.queryMyStudent(text, (Integer)session.getAttribute(Const.USER_TEACHER));
		Map map = new HashMap<>();
		//easyui的分页需要
		map.put("rows", studentList);
		map.put("total", studentList.size());
		return map;
	}
	
	/**
	 * 修改学生信息
	 * @param text
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
			return ServerResponse.createByFailMsg("您没有权限修改该学生成绩，请点击我的学生按钮！");
		}
	}
}
