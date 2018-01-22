package com.ypy.graduationProject.pojo;
/**
 * 题目类
 * @author ypy
 */
public class Title {
	private int cid;
	private String cname;
	private String cscore;
	private String require;
	private String task;
	@Override
	public String toString() {
		return "Title [cid=" + cid + ", cname=" + cname + ", cscore=" + cscore + ", require=" + require + ", task="
				+ task + "]";
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getCscore() {
		return cscore;
	}
	public void setCscore(String cscore) {
		this.cscore = cscore;
	}
	public String getRequire() {
		return require;
	}
	public void setRequire(String require) {
		this.require = require;
	}
	public String getTask() {
		return task;
	}
	public void setTask(String task) {
		this.task = task;
	}
}
