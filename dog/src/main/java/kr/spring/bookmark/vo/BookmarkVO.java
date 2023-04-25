package kr.spring.bookmark.vo;

public class BookmarkVO {
	private int bookmark_num;
	private int walk_num;
	private int hospital_num;
	private int cafe_num;
	private int mem_num;
	private int categories;
	private String mem_id;				//EX.000님의 산책로
	private String h_info_name;				//EX.000동물병원
	private String cafe_name;				//EX.000애견카페
	public int getBookmark_num() {
		return bookmark_num;
	}
	public void setBookmark_num(int bookmark_num) {
		this.bookmark_num = bookmark_num;
	}
	public int getWalk_num() {
		return walk_num;
	}
	public void setWalk_num(int walk_num) {
		this.walk_num = walk_num;
	}
	public int getHospital_num() {
		return hospital_num;
	}
	public void setHospital_num(int hospital_num) {
		this.hospital_num = hospital_num;
	}
	public int getCafe_num() {
		return cafe_num;
	}
	public void setCafe_num(int cafe_num) {
		this.cafe_num = cafe_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getCategories() {
		return categories;
	}
	public void setCategories(int categories) {
		this.categories = categories;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getH_info_name() {
		return h_info_name;
	}
	public void setH_info_name(String h_info_name) {
		this.h_info_name = h_info_name;
	}
	public String getCafe_name() {
		return cafe_name;
	}
	public void setCafe_name(String cafe_name) {
		this.cafe_name = cafe_name;
	}
	@Override
	public String toString() {
		return "BookmarkVO [bookmark_num=" + bookmark_num + ", walk_num=" + walk_num + ", hospital_num=" + hospital_num
				+ ", cafe_num=" + cafe_num + ", mem_num=" + mem_num + ", categories=" + categories + ", mem_id="
				+ mem_id + ", h_info_name=" + h_info_name + ", cafe_name=" + cafe_name + "]";
	}
}
