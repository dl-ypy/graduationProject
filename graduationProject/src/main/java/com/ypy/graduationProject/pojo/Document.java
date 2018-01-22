package com.ypy.graduationProject.pojo;
/**
 * 文档类
 * @author ypy
 */
public class Document {
	private int id;
	private int sid;
	private String foundTime;
	private String updateTime;
	private String dname;
	private String dpath;
	@Override
	public String toString() {
		return "Document [id=" + id + ", sid=" + sid + ", foundTime=" + foundTime + ", updateTime=" + updateTime
				+ ", dname=" + dname + ", dpath=" + dpath + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public String getFoundTime() {
		return foundTime;
	}
	public void setFoundTime(String foundTime) {
		this.foundTime = foundTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getDpath() {
		return dpath;
	}
	public void setDpath(String dpath) {
		this.dpath = dpath;
	}
}
