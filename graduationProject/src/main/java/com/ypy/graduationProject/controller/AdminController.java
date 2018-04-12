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
import com.ypy.graduationProject.service.IAdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private IAdminService iAdminService;
	
	@RequestMapping("/updateAdminPass")
	@ResponseBody
	public ServerResponse updateAdminPass(String oldPassword, String password, String tpassword, HttpSession session) {
		if (session.getAttribute(Const.USER_ADMIN) == null) {
			return ServerResponse.createByFailMsg("请先登录！");
		} else {
			Admin admin = iAdminService.queryIsAdmin((int) session.getAttribute(Const.USER_ADMIN), oldPassword);
			if (admin == null) {
				return ServerResponse.createByFailMsg("原密码错误！");
			} else {
				Admin s = new Admin();
				s.setAid((int) session.getAttribute(Const.USER_ADMIN));
				s.setPassword(tpassword);
				int updateCount = iAdminService.updateAdmin(s);
				if (updateCount > 0) {
					return ServerResponse.createBySuccessMsg("修改成功！");
				} else {
					return ServerResponse.createBySuccessMsg("修改失败！");
				}
			}
		}
	}
	
}
