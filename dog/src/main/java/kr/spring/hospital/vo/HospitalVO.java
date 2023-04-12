package kr.spring.hospital.vo;

import java.io.IOException;
import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class HospitalVO {
	private int hospital_num;
	private int hospital_type;
	private String hospital_region;
	private String coord_x;
	private String coord_y;
	
	private int h_info_num;
	private String h_info_name;
	private String h_info_detail;
	private Date h_info_date;
	private int h_info_auth;
	private int mem_num;
	private byte[] h_info_image;
	private String h_info_image_name;
	
	
	public void setUpload(MultipartFile upload) throws IOException{

		//MultipartFile -> byte[]
		setH_info_image(upload.getBytes());
		//파일 이름
		setH_info_image_name(upload.getOriginalFilename());
	}
	
	public int getHospital_num() {
		return hospital_num;
	}
	public void setHospital_num(int hospital_num) {
		this.hospital_num = hospital_num;
	}
	public int getHospital_type() {
		return hospital_type;
	}
	public void setHospital_type(int hospital_type) {
		this.hospital_type = hospital_type;
	}
	public String getHospital_region() {
		return hospital_region;
	}
	public void setHospital_region(String hospital_region) {
		this.hospital_region = hospital_region;
	}
	public String getCoord_x() {
		return coord_x;
	}
	public void setCoord_x(String coord_x) {
		this.coord_x = coord_x;
	}
	public String getCoord_y() {
		return coord_y;
	}
	public void setCoord_y(String coord_y) {
		this.coord_y = coord_y;
	}
	public int getH_info_num() {
		return h_info_num;
	}
	public void setH_info_num(int h_info_num) {
		this.h_info_num = h_info_num;
	}
	public String getH_info_name() {
		return h_info_name;
	}
	public void setH_info_name(String h_info_name) {
		this.h_info_name = h_info_name;
	}
	public String getH_info_detail() {
		return h_info_detail;
	}
	public void setH_info_detail(String h_info_detail) {
		this.h_info_detail = h_info_detail;
	}
	public Date getH_info_date() {
		return h_info_date;
	}
	public void setH_info_date(Date h_info_date) {
		this.h_info_date = h_info_date;
	}
	public int getH_info_auth() {
		return h_info_auth;
	}
	public void setH_info_auth(int h_info_auth) {
		this.h_info_auth = h_info_auth;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public byte[] getH_info_image() {
		return h_info_image;
	}
	public void setH_info_image(byte[] h_info_image) {
		this.h_info_image = h_info_image;
	}
	public String getH_info_image_name() {
		return h_info_image_name;
	}
	public void setH_info_image_name(String h_info_image_name) {
		this.h_info_image_name = h_info_image_name;
	}
	
	
	
}
