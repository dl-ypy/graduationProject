package com.ypy.graduationProject.pojo;
/**
 * 文档类
 * @author ypy
 */
public class Document {
	private int id;
	private int sid;
	private String updateTime;
	private String dname;
	private String dpath;
	private String agree;
	private String approveTime;
	private String isApprove;
	private String downloadTime;
	
	@Override
	public String toString() {
		return "Document [id=" + id + ", sid=" + sid + ", updateTime=" + updateTime
				+ ", dname=" + dname + ", dpath=" + dpath + ", agree=" + agree + ", approveTime=" + approveTime
				+ ", isApprove=" + isApprove + ", downloadTime=" + downloadTime + "]";
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
	/**
	 * @return the agree
	 */
	public String getAgree() {
		return agree;
	}
	/**
	 * @param agree the agree to set
	 */
	public void setAgree(String agree) {
		this.agree = agree;
	}
	/**
	 * @return the approveTime
	 */
	public String getApproveTime() {
		return approveTime;
	}
	/**
	 * @param approveTime the approveTime to set
	 */
	public void setApproveTime(String approveTime) {
		this.approveTime = approveTime;
	}
	/**
	 * @return the isApprove
	 */
	public String getIsApprove() {
		return isApprove;
	}
	/**
	 * @param isApprove the isApprove to set
	 */
	public void setIsApprove(String isApprove) {
		this.isApprove = isApprove;
	}
	/**
	 * @return the downloadTime
	 */
	public String getDownloadTime() {
		return downloadTime;
	}
	/**
	 * @param downloadTime the downloadTime to set
	 */
	public void setDownloadTime(String downloadTime) {
		this.downloadTime = downloadTime;
	}
}
