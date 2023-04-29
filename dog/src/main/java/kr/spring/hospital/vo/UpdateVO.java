package kr.spring.hospital.vo;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

public class UpdateVO {
	private String place_name;
	private String place_detail;
	private String place_road;
	private String place_address;
	private byte[] place_newImg;
	private String place_newImgName;
	private String pk_num;
	private String hostURL;
	private int mem_num;
	
	public void setUpload(MultipartFile upload) throws IOException{
		//MultipartFile -> byte[]
		setPlace_newImg(upload.getBytes());
		//파일 이름
		setPlace_newImgName(upload.getOriginalFilename());
	}
	
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public String getPlace_detail() {
		return place_detail;
	}
	public void setPlace_detail(String place_detail) {
		this.place_detail = place_detail;
	}
	public String getPlace_road() {
		return place_road;
	}
	public void setPlace_road(String place_road) {
		this.place_road = place_road;
	}
	public String getPlace_address() {
		return place_address;
	}
	public void setPlace_address(String place_address) {
		this.place_address = place_address;
	}
	public byte[] getPlace_newImg() {
		return place_newImg;
	}
	public void setPlace_newImg(byte[] place_newImg) {
		this.place_newImg = place_newImg;
	}
	public String getPlace_newImgName() {
		return place_newImgName;
	}
	public void setPlace_newImgName(String place_newImgName) {
		this.place_newImgName = place_newImgName;
	}

	public String getPk_num() {
		return pk_num;
	}

	public void setPk_num(String pk_num) {
		this.pk_num = pk_num;
	}

	public String getHostURL() {
		return hostURL;
	}

	public void setHostURL(String hostURL) {
		this.hostURL = hostURL;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	@Override
	public String toString() {
		return "UpdateVO [place_name=" + place_name + ", place_detail=" + place_detail + ", place_road=" + place_road
				+ ", place_address=" + place_address + ", place_newImgName=" + place_newImgName + ", pk_num=" + pk_num
				+ ", hostURL=" + hostURL + "]";
	}
	
	
	
}
