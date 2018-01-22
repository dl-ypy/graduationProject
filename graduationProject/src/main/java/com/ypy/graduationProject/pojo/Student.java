package com.ypy.graduationProject.pojo;
/**
 * 学生类
 * @author ypy
 */
public class Student {
	private int id;
	private int sid;
	private int cid;
	private int tid;
	private String sname;
	private String sclass;
	private String ssex;
	private String sphone;
	private String spassword;
	
	@Override
	public String toString() {
		return "Student [id=" + id + ", sid=" + sid + ", cid=" + cid + ", tid=" + tid + ", sname=" + sname + ", sclass="
				+ sclass + ", ssex=" + ssex + ", sphone=" + sphone + ", spassword=" + spassword + "]";
	}
	
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getSclass() {
		return sclass;
	}
	public void setSclass(String sclass) {
		this.sclass = sclass;
	}
	public String getSsex() {
		return ssex;
	}
	public void setSsex(String ssex) {
		this.ssex = ssex;
	}
	public String getSphone() {
		return sphone;
	}
	public void setSphone(String sphone) {
		this.sphone = sphone;
	}
	/**
	 * @return the spassword
	 */
	public String getSpassword() {
		return spassword;
	}
	/**
	 * @param spassword the spassword to set
	 */
	public void setSpassword(String spassword) {
		this.spassword = spassword;
	}
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @return the cid
	 */
	public int getCid() {
		return cid;
	}
	/**
	 * @param cid the cid to set
	 */
	public void setCid(int cid) {
		this.cid = cid;
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
