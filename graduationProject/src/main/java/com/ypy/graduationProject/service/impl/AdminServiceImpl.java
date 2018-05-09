package com.ypy.graduationProject.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ypy.graduationProject.mapper.AdminMapper;
import com.ypy.graduationProject.pojo.Admin;
import com.ypy.graduationProject.service.IAdminService;
@Service
@Transactional  //添加事务
public class AdminServiceImpl implements IAdminService {
	@Autowired
	private AdminMapper adminMapper;
	
	@Override
	public Admin queryIsAdmin(int id, String password) {
		return adminMapper.queryIsAdmin(id, password);
	}

	@Override
	public int updateAdmin(Admin admin) {
		return adminMapper.updateAdmin(admin);
	}

}
