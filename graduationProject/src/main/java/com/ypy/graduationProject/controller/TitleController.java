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
import com.ypy.graduationProject.pojo.Title;
import com.ypy.graduationProject.service.IStudentService;
import com.ypy.graduationProject.service.ITitleService;

@Controller
@RequestMapping("/title")
public class TitleController {
	@Autowired
	private ITitleService iTitleService;
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
	@RequestMapping("/queryTitle")
	@ResponseBody
	public ServerResponse queryTitle(@RequestParam(required=false) String text, HttpSession session) {
		if (session.getAttribute(Const.USER_NAME) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			if (Const.USER_ADMIN==null && Const.USER_TEACHER==null) {
				return ServerResponse.createByFailMsg("请以教师或管理员身份登录！");
			} else {
				List titleList = iTitleService.queryTitle(text, (Integer) session.getAttribute(Const.USER_TEACHER));
				return ServerResponse.createBySuccessPage(titleList, titleList.size());
			}
		}
	}
	
	/**
	 * 学生查询题目
	 * @param text
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryAllTitle")
	@ResponseBody
	public ServerResponse queryAllTitle(@RequestParam(required=false) String text, HttpSession session) {
		if (session.getAttribute(Const.USER_STUDENT) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			List titleList = iTitleService.queryAllTitle(text);
			return ServerResponse.createBySuccessPage(titleList, titleList.size());
		}
	}
	
	/**
	 * 选择题目
	 * @param cid
	 * @param tid
	 * @param session
	 * @return
	 */
	@RequestMapping("/selectTitle")
	@ResponseBody
	public ServerResponse selectTitle(int cid, int tid, HttpSession session) {
		if (session.getAttribute(Const.USER_STUDENT) == null) {
			return ServerResponse.createByFailMsg("请以学生身份登录！");
		} else {
			int userIsSelected = iStudentService.isSelected((int)session.getAttribute(Const.USER_STUDENT));
			if (userIsSelected > 0) {
				int titleIsSelected = iTitleService.isSelected(cid);
				if (titleIsSelected == 0) {
					return ServerResponse.createByFailMsg("该题目已经被选择，请选择其他题目！");
				} else {
					//进行题目的选择  
					//TODO  添加事务
					Student student = new Student();
					student.setCid(cid);
					student.setTid(tid);
					student.setSid((int)session.getAttribute(Const.USER_STUDENT));
					int studentUpdateCount = iStudentService.updateMStudent(student);
					Title title = new Title();
					title.setCid(cid);
					title.setCselected("是");
					int titleUpdateCount = iTitleService.updateTitle(title);
					if (studentUpdateCount>0 && titleUpdateCount>0) {
						return ServerResponse.createBySuccessMsg("恭喜您，选课成功！");
					} else {
						return ServerResponse.createByFailMsg("选课失败！");
					}
				}
			} else {
				return ServerResponse.createByFailMsg("您已选好题目了，请取消原题目的选择再进行尝试！");
			}
		}
	}
	
	@RequestMapping("/unSelectTitle")
	@ResponseBody
	public ServerResponse unSelectTitle(int cid, int tid, HttpSession session) {
		if (session.getAttribute(Const.USER_STUDENT) == null) {
			return ServerResponse.createByFailMsg("请以学生身份登录！");
		} else {
			int userIsSelected = iStudentService.isSelectedByCidAndSid((int)session.getAttribute(Const.USER_STUDENT),cid);
			if (userIsSelected > 0) {
				//进行题目的取消选择  
				//TODO  添加事务
				Student student = new Student();
				student.setCid(-1);
				student.setTid(-1);
				student.setSid((int)session.getAttribute(Const.USER_STUDENT));
				int studentUpdateCount = iStudentService.updateMStudent(student);
				Title title = new Title();
				title.setCid(cid);
				title.setCselected("否");
				int titleUpdateCount = iTitleService.updateTitle(title);
				if (studentUpdateCount>0 && titleUpdateCount>0) {
					return ServerResponse.createBySuccessMsg("取消成功！");
				} else {
					return ServerResponse.createByFailMsg("取消失败！");
				}
			} else {
				return ServerResponse.createByFailMsg("您还未选该题目，不能进行取消操作！");
			}
		}
	}
}
