package kr.spring.walk.vo;

import java.sql.Date;

public class WalkVO {
	private int walk_num;
	private String walk_region;
	private String walk_position;
	
	private int walk_detail_num;
	private int walk_bookmark;
	private Date walk_date;
	private String walk_img;
	private String walk_info;
	private int walk_perm;
	private int mem_num;
	private String mem_id;
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getWalk_img() {
		return walk_img;
	}
	public void setWalk_img(String walk_img) {
		this.walk_img = walk_img;
	}
	public String getWalk_info() {
		return walk_info;
	}
	public void setWalk_info(String walk_info) {
		this.walk_info = walk_info;
	}
	public int getWalk_num() {
		return walk_num;
	}
	public void setWalk_num(int walk_num) {
		this.walk_num = walk_num;
	}
	public String getWalk_region() {
		return walk_region;
	}
	public void setWalk_region(String walk_region) {
		this.walk_region = walk_region;
	}
	public String getWalk_position() {
		return walk_position;
	}
	public void setWalk_position(String walk_position) {
		this.walk_position = walk_position;
	}
	public int getWalk_detail_num() {
		return walk_detail_num;
	}
	public void setWalk_detail_num(int walk_detail_num) {
		this.walk_detail_num = walk_detail_num;
	}
	public int getWalk_bookmark() {
		return walk_bookmark;
	}
	public void setWalk_bookmark(int walk_bookmark) {
		this.walk_bookmark = walk_bookmark;
	}
	public Date getWalk_date() {
		return walk_date;
	}
	public void setWalk_date(Date walk_date) {
		this.walk_date = walk_date;
	}
	public int getWalk_perm() {
		return walk_perm;
	}
	public void setWalk_perm(int walk_perm) {
		this.walk_perm = walk_perm;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	@Override
	public String toString() {
		return "WalkVO [walk_num=" + walk_num + ", walk_region=" + walk_region + ", walk_position=" + walk_position
				+ ", walk_detail_num=" + walk_detail_num + ", walk_bookmark=" + walk_bookmark + ", walk_date="
				+ walk_date + ", walk_img=" + walk_img + ", walk_info=" + walk_info + ", walk_perm=" + walk_perm
				+ ", mem_num=" + mem_num + ", mem_id=" + mem_id + "]";
	}

	
}
