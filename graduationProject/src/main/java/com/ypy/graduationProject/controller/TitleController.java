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
import com.ypy.graduationProject.service.ITitleService;

@Controller
@RequestMapping("/title")
public class TitleController {
	@Autowired
	private ITitleService iTitleService;
	
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
}
