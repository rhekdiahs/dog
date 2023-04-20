package kr.spring.cafe.vo;

import java.sql.Date;

import org.springframework.beans.factory.annotation.Value;

public class CafeVO {
	@Value("${property.key.apikey}")
	private String apikey;
	
	private int cafe_num;
	private String cafe_name;
	private String cafe_x;
	private String cafe_y;
	private String cafe_region;
	private String cafe_addr1;
	private String cafe_addr2;
	private int cafe_cate;
	private String cafe_phone;
	private String cafe_site;
	
	private int cafe_detail_num;
	private String cafe_detail_name;
	private int cafe_type;
	private String cafe_content;
	private String cafe_image_name;
	private byte[] cafe_image;
	private int cafe_status;
	private Date cafe_reg_date;
	private Date cafe_modify_date;
	public String getApikey() {
		return apikey;
	}
	public void setApikey(String apikey) {
		this.apikey = apikey;
	}
	public int getCafe_num() {
		return cafe_num;
	}
	public void setCafe_num(int cafe_num) {
		this.cafe_num = cafe_num;
	}
	public String getCafe_name() {
		return cafe_name;
	}
	public void setCafe_name(String cafe_name) {
		this.cafe_name = cafe_name;
	}
	public String getCafe_x() {
		return cafe_x;
	}
	public void setCafe_x(String cafe_x) {
		this.cafe_x = cafe_x;
	}
	public String getCafe_y() {
		return cafe_y;
	}
	public void setCafe_y(String cafe_y) {
		this.cafe_y = cafe_y;
	}
	public String getCafe_region() {
		return cafe_region;
	}
	public void setCafe_region(String cafe_region) {
		this.cafe_region = cafe_region;
	}
	public String getCafe_addr1() {
		return cafe_addr1;
	}
	public void setCafe_addr1(String cafe_addr1) {
		this.cafe_addr1 = cafe_addr1;
	}
	public String getCafe_addr2() {
		return cafe_addr2;
	}
	public void setCafe_addr2(String cafe_addr2) {
		this.cafe_addr2 = cafe_addr2;
	}
	public int getCafe_cate() {
		return cafe_cate;
	}
	public void setCafe_cate(int cafe_cate) {
		this.cafe_cate = cafe_cate;
	}
	public String getCafe_phone() {
		return cafe_phone;
	}
	public void setCafe_phone(String cafe_phone) {
		this.cafe_phone = cafe_phone;
	}
	public String getCafe_site() {
		return cafe_site;
	}
	public void setCafe_site(String cafe_site) {
		this.cafe_site = cafe_site;
	}
	public int getCafe_detail_num() {
		return cafe_detail_num;
	}
	public void setCafe_detail_num(int cafe_detail_num) {
		this.cafe_detail_num = cafe_detail_num;
	}
	public String getCafe_detail_name() {
		return cafe_detail_name;
	}
	public void setCafe_detail_name(String cafe_detail_name) {
		this.cafe_detail_name = cafe_detail_name;
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
	@Override
	public String toString() {
		return "CafeVO [apikey=" + apikey + ", cafe_num=" + cafe_num + ", cafe_name=" + cafe_name + ", cafe_x=" + cafe_x
				+ ", cafe_y=" + cafe_y + ", cafe_region=" + cafe_region + ", cafe_addr1=" + cafe_addr1 + ", cafe_addr2="
				+ cafe_addr2 + ", cafe_cate=" + cafe_cate + ", cafe_phone=" + cafe_phone + ", cafe_site=" + cafe_site
				+ ", cafe_detail_num=" + cafe_detail_num + ", cafe_detail_name=" + cafe_detail_name + ", cafe_type="
				+ cafe_type + ", cafe_content=" + cafe_content + ", cafe_image_name=" + cafe_image_name
				+ ", cafe_status=" + cafe_status + ", cafe_reg_date=" + cafe_reg_date + ", cafe_modify_date="
				+ cafe_modify_date + "]";
	}

}

