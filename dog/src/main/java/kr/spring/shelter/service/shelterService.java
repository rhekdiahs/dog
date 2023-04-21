package kr.spring.shelter.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;

import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.NoSuchFrameException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Service;

import kr.spring.shelter.controller.shelterController;
import kr.spring.shelter.vo.shelterVO;

@SpringBootApplication
@Service
public class shelterService {
	private WebDriver driver;
	private WebDriver driver2;
	@Value("${driver.path}")
	private String driverPath;
    private static final String url = "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EB%8F%99%EB%AC%BC+%EC%9E%84%EC%8B%9C%EB%B3%B4%ED%98%B8%EC%86%8C&oquery=%EC%9E%84%EC%8B%9C%EB%B3%B4%ED%98%B8%EC%86%8C&tqi=iv%2BQRsprvN8ssSdWX7Nssssstsw-025886";
   
    //private static final String keyword = "임시보호소";
    //private static final String url2 = "https://map.naver.com/v5/search/임시보호소";
    
	private static final Logger logger = LoggerFactory.getLogger(shelterService.class);
    public List<shelterVO> process() {
    	List<shelterVO>  list = new ArrayList<>();
        //크롬 드라이버 셋팅 (드라이버 설치한 경로 입력)
    	//logger.debug("<<driver_path>> : " + driverPath); 
    	System.setProperty("webdriver.chrome.driver", driverPath);
        
    	
        ChromeOptions options = new ChromeOptions();
        options.addArguments("headless");   // 브라우저 안띄움
        options.addArguments("--remote-allow-origins=*");//모든 도메인 요청 허용
        driver = new ChromeDriver(options);
        //브라우저 선택

        try {
             list= getDataList();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        driver.close();	//탭 닫기
        driver.quit();	//브라우저 닫기
        
        return list;
    }


    /**
     * data가져오기
     */
    public List<shelterVO> getDataList() throws InterruptedException {
    	List<shelterVO>  list = new ArrayList<>();
        driver.get(url);    //브라우저에서 url로 이동한다.
        Thread.sleep(1000); //브라우저 로딩될때까지 잠시 기다린다.

        //크롤링 목록
        List<WebElement> contents = driver.findElements(By.cssSelector("li.VLTHu"));
        for (WebElement content : contents) {
        	WebElement cl = content.findElement(By.cssSelector("div.rDx68 span.Q8Zql a.vcshc"));
        	cl.click();
        	String add = content.findElement(By.cssSelector("div.jg1ED div.o8CtQ")).getText();
        	shelterVO shelter = shelterVO.builder()
                    .subject(content.findElement(By.cssSelector("span.place_bluelink")).getText())		// 제목
                    .url(content.findElement(By.cssSelector("div div a")).getAttribute("href"))		// 링크
                    .location(content.findElement(By.cssSelector("span.Q8Zql")).getText()) 			// 위치
                    .address(add.replaceAll("도로명", "").replaceAll("복사", "").replaceAll("지번", "").trim()) // 주소
                    .build();
            list.add(shelter);
        }
        return list;
    }
    
      //상세페이지 보기 
	  public List<shelterVO> getDataDetailList(String url2) throws InterruptedException {
		//url2 = "https://map.naver.com/v5/search/임시보호소";
		System.setProperty("webdriver.chrome.driver", driverPath);
	  	ChromeOptions options = new ChromeOptions();
        options.addArguments("headless");   // 브라우저 안띄움
        options.addArguments("--remote-allow-origins=*");//모든 도메인 요청 허용
        driver2 = new ChromeDriver(options);
        
        List<shelterVO>  list = new ArrayList<>();
        
        try {
	        String value = url2.split("/")[7].split("\\?")[0];
	        logger.debug("<<장소 place>> : " + value);
	        url2 = "https://pcmap.place.naver.com/place/"+value+"/home?";
	        logger.debug("<<상세페이지 들어가는 url2>> : " + url2);
	        
	        
		    driver2.get(url2);    //브라우저에서 url로 이동한다.
		    Thread.sleep(3000); //브라우저 로딩될때까지 잠시 기다린다.
		    
		    WebElement elementInNewIframe = driver2.findElement(By.tagName("title"));
		    //...
		    System.out.println("iframe2---------------------------" + elementInNewIframe);
		    String bodytest = elementInNewIframe.getAttribute("innerHTML");
		    System.out.println("iframe3---------------------------" + bodytest);
	        	
	    	String su = driver2.findElement(By.cssSelector("#_title > span.Fc1rA")).getText();//이름
	    	String ph;//번호
	    	String ti;// 시간
	    	String ex;// 설명
	    	
	    	try{
	    		driver2.findElement(By.cssSelector("span.xlx7Q"));
	    		ph = driver2.findElement(By.cssSelector("span.xlx7Q")).getText();
	    	}catch(NoSuchElementException e) {
	    	    ph = "번호가 없습니다.";
	   		}
	    	
	    	try{
	    		driver2.findElement(By.cssSelector("span.U7pYf > time"));
	    		ti = driver2.findElement(By.cssSelector("span.U7pYf > time")).getText();
	    	}catch(NoSuchElementException e) {
	    	    ti = "영업시간이 없습니다.";
	   		}
	    	
	    	try{
	    		driver2.findElement(By.cssSelector("div.vV_z_ > div > a.xHaT3 > span.zPfVt"));
	    		ex = driver2.findElement(By.cssSelector("div.vV_z_ > div > a.xHaT3 > span.zPfVt")).getText();
	    	}catch(NoSuchElementException e) {
	    	    ex = "설명이 없습니다.";
	   		}
	    	
	    	String ad = driver2.findElement(By.cssSelector("#app-root > div > div > div > div:nth-child(6) > div > div.place_section.no_margin.vKA6F > div > div > div.O8qbU.tQY7D > div > a > span.LDgIH")).getText();
	    		        	
	    	shelterVO shelter = shelterVO.builder()
	    			.subject(su)		// 제목
					.phone(ph) 	// 전화번호
	                .address(ad.replaceAll("도로명", "").replaceAll("복사", "").replaceAll("지번", "").trim()) // 주소
	                .time(ti)
	                .explanation(ex)
	                .build();
	        list.add(shelter);
	        
	        logger.debug("<<상세페이지 list>> : " + list);
        }catch (InterruptedException e) {
            e.printStackTrace();
        }
        
        driver2.close();	//탭 닫기
        driver2.quit();	//브라우저 닫기
        
	    return list;
	  }
}