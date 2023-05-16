package kr.spring.community.vo;

public class CommunityFavVO {
	private int fav_num;
	private int mem_num;
	private int lf_num;
	
	public int getFav_num() {
		return fav_num;
	}
	public void setFav_num(int fav_num) {
		this.fav_num = fav_num;
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
		return "CommunityFavVO [fav_num=" + fav_num + ", mem_num=" + mem_num + ", lf_num=" + lf_num + "]";
	}
	
	
}
