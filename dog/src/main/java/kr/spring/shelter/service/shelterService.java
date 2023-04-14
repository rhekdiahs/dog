package kr.spring.shelter.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Service;

import kr.spring.shelter.controller.shelterController;
import kr.spring.shelter.vo.shelterVO;

@SpringBootApplication
@Service
public class shelterService {
	private WebDriver driver;

    private static final String url = "https://search.naver.com/search.naver?where=nexearch&sm=tab_jum&query=%EC%9E%84%EC%8B%9C%EB%B3%B4%ED%98%B8%EC%86%8C";
	private static final Logger logger = LoggerFactory.getLogger(shelterService.class);
    public List<shelterVO> process() {
    	List<shelterVO>  list = new ArrayList<>();
        //크롬 드라이버 셋팅 (드라이버 설치한 경로 입력)
    	System.setProperty("webdriver.chrome.driver", "C:\\chromedriver_win32\\chromedriver.exe");
        
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
        List<WebElement> contents = driver.findElements(By.cssSelector("section ul.R1Lzz li"));
       
        for (WebElement content : contents) {
        	WebElement cl = content.findElement(By.cssSelector("div.rDx68 span.Q8Zql a.vcshc"));
        	cl.click();
        	shelterVO shelter = shelterVO.builder()
                    .subject(content.findElement(By.cssSelector("span.place_bluelink")).getText())		// 제목
                    .url(content.findElement(By.cssSelector("div div a")).getAttribute("href"))		// 링크
                    .location(content.findElement(By.cssSelector("span.Q8Zql")).getText()) 			// 위치
                    .address(content.findElement(By.cssSelector("div.MaJkh div.o8CtQ")).getText().replaceAll("도로명", "").replaceAll("복사", "").trim()) // 주소
                    .build();
            list.add(shelter);
        }
        return list;
    }
}