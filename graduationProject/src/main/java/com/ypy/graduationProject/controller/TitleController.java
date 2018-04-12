package com.ypy.graduationProject.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.ypy.graduationProject.pojo.Title;
import com.ypy.graduationProject.service.IStudentService;
import com.ypy.graduationProject.service.ITeacherService;
import com.ypy.graduationProject.service.ITitleService;

@Controller
@RequestMapping("/title")
public class TitleController {
	@Autowired
	private ITitleService iTitleService;
	@Autowired
	private IStudentService iStudentService;
	@Autowired
	private ITeacherService iTeacherService;
	
	/**
	 * 教师查询题目
	 * @param text
	 * @param isSelected
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryTitle")
	@ResponseBody
	public ServerResponse queryTitle(@RequestParam(required=false) String text, @RequestParam(required=false) String isSelected, HttpSession session) {
		if (session.getAttribute(Const.USER_NAME) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			if (Const.USER_TEACHER == null) {
				return ServerResponse.createByFailMsg("请以教师身份登录！");
			} else {
				List titleList = iTitleService.queryTitle(text, isSelected, (Integer) session.getAttribute(Const.USER_TEACHER));
				return ServerResponse.createBySuccessPage(titleList, titleList.size());
			}
		}
	}
	
	/**
	 * 管理员查询题目
	 * @param text
	 * @param isSelected
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryTitleByAdmin")
	@ResponseBody
	public ServerResponse queryTitleByAdmin(@RequestParam(required=false) String text, @RequestParam(required=false) String isSelected, HttpSession session) {
		if (session.getAttribute(Const.USER_NAME) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			if (Const.USER_ADMIN == null) {
				return ServerResponse.createByFailMsg("请以管理员身份登录！");
			} else {
				List titleList = iTitleService.queryTitle(text, isSelected, -1);
				return ServerResponse.createBySuccessPage(titleList, titleList.size());
			}
		}
	}
	
	/**
	 * 学生查询题目
	 * @param text
	 * @param isSelected
	 * @param session
	 * @return
	 */
	@RequestMapping("/queryAllTitle")
	@ResponseBody
	public ServerResponse queryAllTitle(@RequestParam(required=false) String text, @RequestParam(required=false) String isSelected, HttpSession session) {
		if (session.getAttribute(Const.USER_STUDENT) == null) {
			return ServerResponse.createByFailMsg("请登录！");
		} else {
			List titleList = iTitleService.queryAllTitle(text, isSelected);
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
	
	/**
	 * 取消题目的选择
	 * @param cid
	 * @param tid
	 * @param session
	 * @return
	 */
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
	
	/**
	 * 修改题目信息
	 * @param title
	 * @param session
	 * @return
	 */
	@RequestMapping("/updateTitle")
	@ResponseBody
	public ServerResponse updateTitle(Title title, HttpSession session) {
		if (session.getAttribute(Const.USER_ADMIN) == null) {
			return ServerResponse.createByFailMsg("请以管理员身份登录！");
		} else {
			Date date = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			title.setUpdateTime(df.format(date));
			
			
			int updateCount = iTitleService.updateTitle(title);
			
			if (updateCount > 0) {
				return ServerResponse.createBySuccessMsg("修改成功！");
			}
			return ServerResponse.createByFailMsg("修改失败！");
		}
	}
	
	/**
	 * 添加题目信息
	 * @param title
	 * @param session
	 * @return
	 */
	@RequestMapping("/addTitle")
	@ResponseBody
	public ServerResponse addTitle(Title title, int tid, HttpSession session) {
		if (session.getAttribute(Const.USER_ADMIN) == null) {
			return ServerResponse.createByFailMsg("请以管理员身份登录！");
		} else {
			Date date = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			title.setUpdateTime(df.format(date));
			Teacher teacher = new Teacher();
			teacher.setTid(tid);
			Teacher teacher1 = iTeacherService.queryIsTeacher(tid, null);
			teacher.setTcount(teacher1.getTcount()+1);   //要将教师负责题目数加1
			int teacherUpdateCount = iTeacherService.updateTeacher(teacher);
			title.setTid(tid);
			int updateCount = iTitleService.addTitle(title);
			if (updateCount>0  && teacherUpdateCount>0) {
				return ServerResponse.createBySuccessMsg("添加成功！");
			}
			return ServerResponse.createByFailMsg("添加失败！");
		}
	}
	
	/**
	 * 删除题目
	 * @param cid
	 * @param session
	 * @return
	 */
	@RequestMapping("/deleteTitle")
	@ResponseBody
	public ServerResponse deleteTitle(int cid, int tid, HttpSession session) {
		if (session.getAttribute(Const.USER_ADMIN) == null) {
			return ServerResponse.createByFailMsg("请以管理员身份登录！");
		} else {
			int selectCount = iTitleService.isSelected(cid);
			if (selectCount > 0) {   //表示该题目没有被选择
				int deleteCount = iTitleService.deleteTitle(cid);   //TODO  添加事务回滚
				if (deleteCount > 0) {
					Teacher teacher = iTeacherService.queryIsTeacher(tid, null);
					Teacher teacher1 = new Teacher();
					teacher1.setTid(tid);
					teacher1.setTcount(teacher.getTcount()-1);
					int updateCount = iTeacherService.updateTeacher(teacher1);
					if (updateCount > 0) {
						return ServerResponse.createBySuccessMsg("删除成功！");
					}
				}
				return ServerResponse.createByFailMsg("删除失败！");
			}
			return ServerResponse.createByFailMsg("该题目已被学生选择，不能删除！");
		}
	}
}
