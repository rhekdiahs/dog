package kr.spring.cafe.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

public class CafeVO {
	private int cafe_num;
	@NotEmpty
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
	@NotEmpty
	private String cafe_content;
	private String cafe_image_name;
	private byte[] cafe_image;
	private int cafe_status;
	private Date cafe_reg_date;
	private Date cafe_modify_date;
	
	private int mem_num;
	
	
	//====이미지 BLOB 처리====//
		//(주의)폼에서 파일업로드 파라미터네임은 반드시 upload로 지정해야 함(mem_photo로 하면 안 됨! upload로 받은 걸 photo로 바꿀 거라서)
		public void setUpload(MultipartFile upload) throws IOException{

			//MultipartFile -> byte[]
			setCafe_image(upload.getBytes());
			//파일 이름
			setCafe_image_name(upload.getOriginalFilename());
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


	@Override
	public String toString() {
		return "CafeVO [cafe_num=" + cafe_num + ", cafe_name=" + cafe_name + ", cafe_x=" + cafe_x + ", cafe_y=" + cafe_y
				+ ", cafe_region=" + cafe_region + ", cafe_addr1=" + cafe_addr1 + ", cafe_addr2=" + cafe_addr2
				+ ", cafe_cate=" + cafe_cate + ", cafe_phone=" + cafe_phone + ", cafe_site=" + cafe_site
				+ ", cafe_detail_num=" + cafe_detail_num + ", cafe_content=" + cafe_content + ", cafe_image_name=" + cafe_image_name
				+ ", cafe_status=" + cafe_status + ", cafe_reg_date=" + cafe_reg_date + ", cafe_modify_date="
				+ cafe_modify_date + ", mem_num=" + mem_num + "]";
	}

	
	
}

