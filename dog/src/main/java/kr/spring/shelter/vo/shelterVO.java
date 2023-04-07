package kr.spring.shelter.vo;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
@ToString
@Getter
@Builder
public class shelterVO {
	private String image;
    private String subject;
    private String location;
    private String url;
    private String address;
}
