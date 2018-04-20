package com.ypy.graduationProject.common;
/**
 * 常量类
 * @author ypy
 */
public class Const {
	//服务器返回状态 0表示成功，1表示失败
	public static final int SUCCESS_STATUS = 0; 
	public static final int FAIL_STATUS = 1;
	
	//登录的用户
	public static final String USER_TEACHER = "user_teacher";
	public static final String USER_STUDENT = "user_student";
	public static final String USER_ADMIN = "user_admin";
	public static final String USER_NAME = "user_name";
	
	//每位教师负责题目数
	public static final int TEACHER_TITLE_COUNT = 3;
	
	//文档名称
	public static final String[] DOCUMENT_NAME = new String[]{"开题报告","中期检查","说明书","论文"};  
}
