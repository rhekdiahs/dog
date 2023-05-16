package kr.spring.community.vo;

import java.sql.Date;

public class CommunityReplyVO {
	private int re_num;
	private Date re_date;
	private Date re_modify_date;
	private String re_content;
	private int mem_num;
	private int lf_num;
	
	private String mem_id;
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getRe_num() {
		return re_num;
	}
	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}
	public Date getRe_date() {
		return re_date;
	}
	public void setRe_date(Date re_date) {
		this.re_date = re_date;
	}
	public Date getRe_modify_date() {
		return re_modify_date;
	}
	public void setRe_modify_date(Date re_modify_date) {
		this.re_modify_date = re_modify_date;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getLf_num() {
		return lf_num;
	}
	public void setLf_num(int lf_num) {
		this.lf_num = lf_num;
	}
	@Override
	public String toString() {
		return "CommunityReplyVO [re_num=" + re_num + ", re_date=" + re_date + ", re_modify_date=" + re_modify_date
				+ ", re_content=" + re_content + ", mem_num=" + mem_num + ", lf_num=" + lf_num + "]";
	}
	
	
}
