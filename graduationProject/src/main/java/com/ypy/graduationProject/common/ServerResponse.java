package com.ypy.graduationProject.common;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

/**
 * 服务器的响应信息
 * 注：必须有get方法
 * @author ypy
 */
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL) //表示序列化时，如果有值为null的字段，就不对该字段进行序列化
public class ServerResponse<T> implements Serializable{
	private int status;  //服务器响应状态，0表示响应成功, 1表示失败
	private String msg;  //服务器返回的信息
	private T data;      //返回的数据
	private List rows; //easyui的分页需要  结果集
	private int total;  //easyui的分页需要  记录数
	
	public List getRows() {
		return rows;
	}

	public int getTotal() {
		return total;
	}

	
	public int getStatus() {
		return status;
	}

	public String getMsg() {
		return msg;
	}

	public T getData() {
		return data;
	}

	private ServerResponse(int status, String msg) {
		this.status = status;
		this.msg = msg;
	}
	
	private ServerResponse(int status, T data) {
		this.status = status;
		this.data = data;
	}
	
	private ServerResponse(int status, T data, String msg) {
		this.status = status;
		this.data = data;
		this.msg = msg;
	}
	
	private ServerResponse(List rows, int total) {
		this.rows = rows;
		this.total = total;
	}
	
	public static<T> ServerResponse<T> createBySuccessData(T data) {
		return new ServerResponse<T>(Const.SUCCESS_STATUS, data);
	}
	
	public static<T> ServerResponse<T> createBySuccessMsg(String msg) {
		return new ServerResponse<T>(Const.SUCCESS_STATUS, msg);
	}
	
	public static<T> ServerResponse<T> createBySuccess(T data, String msg) {
		return new ServerResponse<T>(Const.SUCCESS_STATUS, data, msg);
	}
	
	public static<T> ServerResponse<T> createByFailData(T data) {
		return new ServerResponse<T>(Const.FAIL_STATUS, data);
	}
	
	public static<T> ServerResponse<T> createByFailMsg(String msg) {
		return new ServerResponse<T>(Const.FAIL_STATUS, msg);
	}
	
	public static<T> ServerResponse<T> createByFail(T data, String msg) {
		return new ServerResponse<T>(Const.FAIL_STATUS, data, msg);
	}
	
	public static<T> ServerResponse<T> createBySuccessPage(List rows, int total) {
		return new ServerResponse<>(rows, total);
	}
}
