package kr.spring.community.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

public class CommunityVO {
	private int lf_num;
	@NotEmpty
	private String lf_title;
	@NotEmpty
	private String lf_content;
	private Date lf_date;
	private Date lf_modify_date;
	private String lf_imgsrc;
	private int lf_hit;
	private byte[] lf_ufile;
	private int mem_num;
	
	private String mem_id;
	private byte[] photo;
	private String photo_name;
	public byte[] getPhoto() {
		return photo;
	}


	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}


	public String getPhoto_name() {
		return photo_name;
	}


	public void setPhoto_name(String photo_name) {
		this.photo_name = photo_name;
	}


	public String getMem_id() {
		return mem_id;
	}


	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}


	//파일 업로드 처리 blob
	public void setUpload(MultipartFile upload)throws IOException{
		//multipartFile -> byte[]변환
		setLf_ufile(upload.getBytes());
		//파일명 구하기
		setLf_imgsrc(upload.getOriginalFilename());
	}
	
	
	public int getLf_num() {
		return lf_num;
	}
	public void setLf_num(int lf_num) {
		this.lf_num = lf_num;
	}
	public String getLf_title() {
		return lf_title;
	}
	public void setLf_title(String lf_title) {
		this.lf_title = lf_title;
	}
	public String getLf_content() {
		return lf_content;
	}
	public void setLf_content(String lf_content) {
		this.lf_content = lf_content;
	}
	public Date getLf_date() {
		return lf_date;
	}
	public void setLf_date(Date lf_date) {
		this.lf_date = lf_date;
	}
	public Date getLf_modify_date() {
		return lf_modify_date;
	}
	public void setLf_modify_date(Date lf_modify_date) {
		this.lf_modify_date = lf_modify_date;
	}
	public String getLf_imgsrc() {
		return lf_imgsrc;
	}
	public void setLf_imgsrc(String lf_imgsrc) {
		this.lf_imgsrc = lf_imgsrc;
	}
	public int getLf_hit() {
		return lf_hit;
	}
	public void setLf_hit(int lf_hit) {
		this.lf_hit = lf_hit;
	}
	public byte[] getLf_ufile() {
		return lf_ufile;
	}
	public void setLf_ufile(byte[] lf_ufile) {
		this.lf_ufile = lf_ufile;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	@Override
	public String toString() {
		return "CommunityVO [lf_num=" + lf_num + ", lf_title=" + lf_title + ", lf_content=" + lf_content + ", lf_date="
				+ lf_date + ", lf_modify_date=" + lf_modify_date + ", lf_imgsrc=" + lf_imgsrc + ", lf_hit=" + lf_hit
				+ ", mem_num=" + mem_num + "]";
	}
	
	
}
