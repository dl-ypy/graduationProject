package com.ypy.graduationProject.pojo;
/**
 * 教师类
 * @author ypy
 *
 */
public class Teacher {
	private int id;
	private int tid;
	private String tname;
	private String tphone;
	private String tpassword;
	@Override
	public String toString() {
		return "Teacher [id=" + id + ", tid=" + tid + ", tname=" + tname + ", tphone=" + tphone + ", tpassword="
				+ tpassword + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getTphone() {
		return tphone;
	}
	public void setTphone(String tphone) {
		this.tphone = tphone;
	}
	public String getTpassword() {
		return tpassword;
	}
	public void setTpassword(String tpassword) {
		this.tpassword = tpassword;
	}
}
