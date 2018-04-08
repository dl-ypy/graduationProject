package com.ypy.graduationProject.controller;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ypy.graduationProject.common.Const;
import com.ypy.graduationProject.common.ServerResponse;
import com.ypy.graduationProject.pojo.Student;
import com.ypy.graduationProject.pojo.Teacher;
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
	 * 教师修改学生信息
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
			//最终评分
			String[] score = new String[4];
			score[0] = student.getScore1();
			score[1] = student.getScore2();
			score[2] = student.getScore3();
			score[3] = student.getScore4();
			int DCount = 0;
			int CCount = 0;
			int BCount = 0;
			int ACount = 0;
			for (int i=0; i<score.length; i++) {
				if ("D".equals(score[i])) {
					DCount++;
				} else if ("C".equals(score[i])) {
					CCount++;
				} else if ("B".equals(score[i])) {
					BCount++;
				} else if ("A".equals(score[i])) {
					ACount++;
				}
			}
			if ((ACount+BCount+CCount+DCount) == 4) {
				if (DCount >= 1) {
					student.setTotalScore("D");
				} else if ((CCount==4) || (CCount==3&&BCount==1)) {
					student.setTotalScore("C");
				} else if ((ACount==4) || (ACount==3&&BCount==1)) {
					student.setTotalScore("A");
				} else {
					student.setTotalScore("B");
				}
			} else {
				student.setTotalScore("未全部评完");
			}
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
	
	/**
	 * 查询单个学生
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryOneStudent")
	@ResponseBody
	public ServerResponse queryOneStudent(HttpSession session) {
		if (session.getAttribute(Const.USER_STUDENT) == null) {
			return ServerResponse.createByFailMsg("请先登录！");
		}
		Student student = iStudentService.queryOneStudent((int) session.getAttribute(Const.USER_STUDENT));
		if (student != null) {
			return ServerResponse.createBySuccessData(student);
		} 
		return ServerResponse.createByFailMsg("查询失败！");
	}
	
	/**
	 * 学生自己修改信息
	 * @param student
	 * @param session
	 * @return
	 */
	@RequestMapping("/updateMStudent")
	@ResponseBody
	public ServerResponse updateMStudent(Student student, HttpSession session) {
		if (session.getAttribute(Const.USER_STUDENT) == null) {
			return ServerResponse.createByFailMsg("请先登录！");
		}
		int sid = (Integer) session.getAttribute(Const.USER_STUDENT);
		student.setSid(sid);   //确保修改的是自己的信息
		int count = iStudentService.updateMStudent(student);
		if (count > 0) {
			if (student.getSname() != null) {
				session.setAttribute(Const.USER_NAME, student.getSname());  //将session中的名字也进行修改
			}
			return ServerResponse.createBySuccessMsg("修改成功！");
		} else {
			return ServerResponse.createByFailMsg("修改失败！");
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
	@RequestMapping("/updateStudentPass")
	@ResponseBody
	public ServerResponse updateTeacherPass(String oldPassword, String password, String tpassword, HttpSession session) {
		if (session.getAttribute(Const.USER_STUDENT) == null) {
			return ServerResponse.createByFailMsg("请先登录！");
		} else {
			Student student = iStudentService.queryIsStudent((int) session.getAttribute(Const.USER_STUDENT), oldPassword);
			if (student == null) {
				return ServerResponse.createByFailMsg("原密码错误！");
			} else {
				Student s = new Student();
				s.setSid((int) session.getAttribute(Const.USER_STUDENT));
				s.setSpassword(tpassword);
				int updateCount = iStudentService.updateMStudent(s);
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
	@RequestMapping("/queryStudentUserName")
	@ResponseBody
	public ServerResponse queryTeacherUserName(HttpSession session) {
		if (session.getAttribute(Const.USER_STUDENT) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			return ServerResponse.createBySuccessMsg((String) session.getAttribute(Const.USER_NAME));
		}
	}
}
