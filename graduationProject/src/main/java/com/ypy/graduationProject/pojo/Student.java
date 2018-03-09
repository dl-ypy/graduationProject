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
	private String score1;
	private String score2;
	private String score3;
	private String score4;
	
	@Override
	public String toString() {
		return "Student [id=" + id + ", sid=" + sid + ", cid=" + cid + ", tid=" + tid + ", sname=" + sname + ", sclass="
				+ sclass + ", ssex=" + ssex + ", sphone=" + sphone + ", spassword=" + spassword + ", score1=" + score1
				+ ", score2=" + score2 + ", score3=" + score3 + ", score4=" + score4 + "]";
	}
	public String getScore1() {
		return score1;
	}
	public void setScore1(String score1) {
		this.score1 = score1;
	}
	public String getScore2() {
		return score2;
	}
	public void setScore2(String score2) {
		this.score2 = score2;
	}
	public String getScore3() {
		return score3;
	}
	public void setScore3(String score3) {
		this.score3 = score3;
	}
	public String getScore4() {
		return score4;
	}
	public void setScore4(String score4) {
		this.score4 = score4;
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
