package kr.spring.cafe.service;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Driver;
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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Service
public class CafeCrawlService {
	/*
	private static final Logger logger = LoggerFactory.getLogger(CafeCrawlService.class);
	
	
	private static String Cafe_URL="https://search.daum.net/search?nil_suggest=btn&w=tot&DA=SBC&q=%EC%95%A0%EA%B2%AC%EC%B9%B4%ED%8E%98";
	
	//jsoup
	@PostConstruct
	 public List<CafeCrawl> getCafeCrawlDatas() throws IOException{
		List<CafeCrawl> cafeList = new ArrayList<>();
		
		Document document = Jsoup.connect(Cafe_URL).get();
		
		Elements contents = document.select("div ul.list_place li");
		
		for (Element content : contents) {
			CafeCrawl cafeCrawl = CafeCrawl.builder()
				                    .subject(content.select("a.fn_tit").text())		 // 제목
				                    .image(content.select("a.thumb_bf img").attr("abs:src")) // 이미지
				                    .type(content.select("div.inner_tit span.f_nb").text()) //카페 종류
				                    .address(content.select("div.layer_item dd.cont span.txt_addr").text())
				                    .url(content.select("div.inner_tit a").attr("abs:href")) // 링크
				                    .build();
            cafeList.add(cafeCrawl);
		}
		logger.debug("카페 크롤링 테스트 : " + cafeList);
		return cafeList;
	}
	*/
	
	/*
	//selenium
	private WebDriver driver;
									 //https://map.kakao.com/?q={keyword}
	private static final String url = "https://map.kakao.com/?q=애견카페";
	
	
	public void process() {
		Path path = Paths.get("C:\\chromedriver_win32\\chromedriver.exe");
		System.setProperty("webdriver.chrome.driver", path.toString());
		
		driver = new ChromeDriver();
		
		try {
			getSelList();
		}catch(InterruptedException e) {
			e.printStackTrace();
		}
		
		driver.close();
		driver.quit();
	}
	
	private List<CafeCrawl> getSelList() throws InterruptedException{
		
		List<CafeCrawl> list = new ArrayList<>();
		
		driver.get(url);
		
		Thread.sleep(1000);
			
		List<WebElement> cafeCrawl = driver.findElements(By.tagName("div.section ul.placelist li.PlaceItem"));
		
		for (WebElement cafe : cafeCrawl) {
	        String subject = cafe.findElement(By.tagName("div.head_item a.link_name")).getText();
		}	
		return list;
	}
	*/
}













