package com.ypy.graduationProject.pojo;
/**
 * 题目类
 * @author ypy
 */
public class Title {
	private int cid;
	private int tid;
	private String cname;
	private String cselected;
	private String require;
	private String task;
	private String updateTime;
	private String updateName;
	
	@Override
	public String toString() {
		return "Title [cid=" + cid + ", tid=" + tid + ", cname=" + cname + ", cselected=" + cselected + ", require="
				+ require + ", task=" + task + ", updateTime=" + updateTime + ", updateName=" + updateName + "]";
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
	/**
	 * @return the cselected
	 */
	public String getCselected() {
		return cselected;
	}
	/**
	 * @param cselected the cselected to set
	 */
	public void setCselected(String cselected) {
		this.cselected = cselected;
	}
	/**
	 * @return the updateTime
	 */
	public String getUpdateTime() {
		return updateTime;
	}
	/**
	 * @param updateTime the updateTime to set
	 */
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	/**
	 * @return the updateName
	 */
	public String getUpdateName() {
		return updateName;
	}
	/**
	 * @param updateName the updateName to set
	 */
	public void setUpdateName(String updateName) {
		this.updateName = updateName;
	}
	/**
	 * @return the tid
	 */
	public int getTid() {
		return tid;
	}
	/**
	 * @param tid the tid to set
	 */
	public void setTid(int tid) {
		this.tid = tid;
	}
}
