package com.ypy.graduationProject.pojo;

public class Admin {
	private int aid;
	private String name;
	private String password;
	@Override
	public String toString() {
		return "Admin [aid=" + aid + ", name=" + name + ", password=" + password + "]";
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
