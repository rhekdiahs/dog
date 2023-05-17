package kr.spring.community.vo;

import java.sql.Date;

public class CommunityAlarmVO {
	private int al_num;
	private int al_read;//0 : 읽음 1 : 안읽음
	private int al_type;//0 : 좋아요, 1 : 태그, 2 : 댓글 
	private Date al_date;
	private int re_num;
	private int mem_num;
	private int lf_num;
	private String mem_id;//상대방의 아이디 
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getAl_num() {
		return al_num;
	}
	public void setAl_num(int al_num) {
		this.al_num = al_num;
	}
	public int getAl_read() {
		return al_read;
	}
	public void setAl_read(int al_read) {
		this.al_read = al_read;
	}
	public int getAl_type() {
		return al_type;
	}
	public void setAl_type(int al_type) {
		this.al_type = al_type;
	}
	public Date getAl_date() {
		return al_date;
	}
	public void setAl_date(Date al_date) {
		this.al_date = al_date;
	}
	public int getRe_num() {
		return re_num;
	}
	public void setRe_num(int re_num) {
		this.re_num = re_num;
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
		return "CommunityAlarmVO [al_num=" + al_num + ", al_read=" + al_read + ", al_type=" + al_type + ", al_date="
				+ al_date + ", re_num=" + re_num + ", mem_num=" + mem_num + ", lf_num=" + lf_num + "]";
	}
	
		
	
}
