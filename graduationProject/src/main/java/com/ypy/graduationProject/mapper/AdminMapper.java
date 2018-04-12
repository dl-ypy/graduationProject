package com.ypy.graduationProject.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ypy.graduationProject.pojo.Admin;
@Mapper
public interface AdminMapper {
	Admin queryIsAdmin(@Param("id") int id, @Param("password") String password);
	int updateAdmin(Admin admin);
}
