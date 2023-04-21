package kr.spring.shelter.vo;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
@ToString
@Getter
@Builder
public class shelterVO {
    private String subject;//이름
    private String location;//위치
    private String url;//상세보기 들어가기 위해서 필요
    private String address;//도로명 주소
    private String phone;//전화번호
    private String explanation;//설명
    private String time;//영업시간
}

