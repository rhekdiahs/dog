package kr.spring.shelter.service;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
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
    	Map<String, Object> prefs = new HashMap<String, Object>();
    	
        ChromeOptions options = new ChromeOptions();
        options.addArguments("headless");   // 브라우저 안띄움
        options.addArguments("disable-gpu");//gpu 가속 비활성화
        options.addArguments("disable-infobars"); //브라우저에서 다운로드나 알림 등의 메시지를 표시하는 기능 비활성화
        options.addArguments("--disable-extensions"); //확장 프로그램(Extensions)을 비활성화
        options.addArguments("--remote-allow-origins=*");//모든 도메인 요청 허용
        //options.addArguments("--disable-application-cache");//캐시 사용하지 않기
        options.addArguments("--blink-settings=imagesEnabled=false"); //이미지 다운 안받음
        
        //prefs.put("profile.managed_default_content_settings.images", 2);//이미지 로딩 비활성화
        
        //options.setExperimentalOption("prefs", prefs);
        
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
        Thread.sleep(450); //브라우저 로딩될때까지 잠시 기다린다.
        //WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        // 웹 요소 대기
        //WebElement element = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("li.VLTHu")));
        
        try {
        //크롤링 목록
        List<WebElement> contents = driver.findElements(By.cssSelector("li.VLTHu"));
        for (WebElement content : contents) {
        	WebElement cl = content.findElement(By.cssSelector("div.rDx68 span.Q8Zql a.vcshc"));
        	cl.click();
        	String add = null;
        	add = content.findElement(By.cssSelector("div.jg1ED > div.o8CtQ")).getText();//주소
        	
        	shelterVO shelter = shelterVO.builder()
                    .subject(content.findElement(By.cssSelector("span.place_bluelink")).getText())		// 제목
                    .url(content.findElement(By.cssSelector("div div a")).getAttribute("href"))		// 링크
                    .location(content.findElement(By.cssSelector("span.Q8Zql")).getText()) 			// 위치
                    .address(add.replaceAll("도로명", "").replaceAll("복사", "").replaceAll("지번", "").trim()) // 주소
                    .build();
            list.add(shelter);
        }
        }catch(NoSuchElementException e) {
        	list = null;
        	return list;
        }
        return list;
    }
    
      //상세페이지 보기 
	  public List<shelterVO> getDataDetailList(String url2) throws InterruptedException {
		
        List<shelterVO>  list = new ArrayList<>();
	        String value = url2.split("/")[7].split("\\?")[0];
	        
	        url2 = "https://pcmap.place.naver.com/place/"+value+"/home?";
	        logger.debug("<<url 값>> : " + url2);
	        Document doc = null;
			try {
				doc = Jsoup.connect(url2).get();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	        
	    	String su = doc.select("#_title > span.Fc1rA").text();//이름
	    	String ph;//번호
	    	String ti;// 시간
	    	String ex;// 설명
	    	String home;//홈페이지
	    	
	    	if(!doc.select("span.xlx7Q").isEmpty()) {
	    		ph = doc.select("span.xlx7Q").text();
	    	}else{
	    	    ph = "번호가 없습니다.";
	   		}
	    	
	    	if(!doc.select("span.U7pYf > time").isEmpty()){
	    		ti = doc.select("span.U7pYf > time").text();
	    	}else{
	    	    ti = "영업시간이 없습니다.";
	   		}
	    	
	    	if(!doc.select("span.zPfVt").isEmpty()){
	    		ex = doc.select("span.zPfVt").first().text();
	    	}else {
	    	    ex = "설명이 없습니다.";
	   		}
	    	
	    	if(!doc.select("div.jO09N > a.CHmqa").isEmpty()){
	    		home = doc.select("div.jO09N > a.CHmqa").attr("href");
	    	}else {
	    	    home = "홈페이지가 없습니다.";
	   		}
	    		
	    	String ad = doc.select("#app-root > div > div > div > div:nth-child(6) > div > div.place_section.no_margin.vKA6F > div > div > div.O8qbU.tQY7D > div > a > span.LDgIH").text();
	        
	    	shelterVO shelter = shelterVO.builder()
	    			.subject(su)		// 제목
					.phone(ph) 	// 전화번호
	                .address(ad.replaceAll("도로명", "").replaceAll("복사", "").replaceAll("지번", "").trim()) // 주소
	                .time(ti) //영업시간
	                .explanation(ex) //설명
	                .blog(home) //홈페이지	
	                //.img(src)
	                .build();
	        list.add(shelter);
	        
	        logger.debug("<<상세페이지 list>> : " + list);
	    return list;
	  }
}