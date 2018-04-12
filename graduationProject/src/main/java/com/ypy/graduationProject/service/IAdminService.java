package com.ypy.graduationProject.service;

import com.ypy.graduationProject.pojo.Admin;

public interface IAdminService {
	Admin queryIsAdmin(int id, String password);
	int updateAdmin(Admin admin);
}
