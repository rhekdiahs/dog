package kr.spring.cafe.vo;

import java.sql.Date;

public class CafeVO {
	private int cafe_num;
	private double cafe_lat;
	private double cafe_lng;
	private String cafe_region;
	
	private int cafe_detail_num;
	private String cafe_name;
	private int cafe_type;
	private String cafe_content;
	private String cafe_image_name;
	private byte[] cafe_image;
	private int cafe_status;
	private Date cafe_reg_date;
	private Date cafe_modify_date;
	
	private int mem_num;
	
	//크롤링
	private String image;
	private String subject;
	private String url;

	public int getCafe_num() {
		return cafe_num;
	}

	public void setCafe_num(int cafe_num) {
		this.cafe_num = cafe_num;
	}

	public double getCafe_lat() {
		return cafe_lat;
	}

	public void setCafe_lat(double cafe_lat) {
		this.cafe_lat = cafe_lat;
	}

	public double getCafe_lng() {
		return cafe_lng;
	}

	public void setCafe_lng(double cafe_lng) {
		this.cafe_lng = cafe_lng;
	}

	public String getCafe_region() {
		return cafe_region;
	}

	public void setCafe_region(String cafe_region) {
		this.cafe_region = cafe_region;
	}

	public int getCafe_detail_num() {
		return cafe_detail_num;
	}

	public void setCafe_detail_num(int cafe_detail_num) {
		this.cafe_detail_num = cafe_detail_num;
	}

	public String getCafe_name() {
		return cafe_name;
	}

	public void setCafe_name(String cafe_name) {
		this.cafe_name = cafe_name;
	}

	public int getCafe_type() {
		return cafe_type;
	}

	public void setCafe_type(int cafe_type) {
		this.cafe_type = cafe_type;
	}

	public String getCafe_content() {
		return cafe_content;
	}

	public void setCafe_content(String cafe_content) {
		this.cafe_content = cafe_content;
	}

	public String getCafe_image_name() {
		return cafe_image_name;
	}

	public void setCafe_image_name(String cafe_image_name) {
		this.cafe_image_name = cafe_image_name;
	}

	public byte[] getCafe_image() {
		return cafe_image;
	}

	public void setCafe_image(byte[] cafe_image) {
		this.cafe_image = cafe_image;
	}

	public int getCafe_status() {
		return cafe_status;
	}

	public void setCafe_status(int cafe_status) {
		this.cafe_status = cafe_status;
	}

	public Date getCafe_reg_date() {
		return cafe_reg_date;
	}

	public void setCafe_reg_date(Date cafe_reg_date) {
		this.cafe_reg_date = cafe_reg_date;
	}

	public Date getCafe_modify_date() {
		return cafe_modify_date;
	}

	public void setCafe_modify_date(Date cafe_modify_date) {
		this.cafe_modify_date = cafe_modify_date;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	
	//크롤링
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Override
	public String toString() {
		return "CafeVO [cafe_num=" + cafe_num + ", cafe_lat=" + cafe_lat + ", cafe_lng=" + cafe_lng + ", cafe_region="
				+ cafe_region + ", cafe_detail_num=" + cafe_detail_num + ", cafe_name=" + cafe_name + ", cafe_type="
				+ cafe_type + ", cafe_content=" + cafe_content + ", cafe_image_name=" + cafe_image_name
				+ ", cafe_status=" + cafe_status + ", cafe_reg_date=" + cafe_reg_date + ", cafe_modify_date="
				+ cafe_modify_date + ", mem_num=" + mem_num + "]";
	}
	
}
