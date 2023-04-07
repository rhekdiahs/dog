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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.spring.shelter.controller.shelterController;
import kr.spring.shelter.vo.shelterVO;

@Service
public class shelterService {
	private static String URL = "https://search.naver.com/search.naver?where=nexearch&sm=tab_jum&query=%EC%9E%84%EC%8B%9C%EB%B3%B4%ED%98%B8%EC%86%8C";
	private static final Logger logger = LoggerFactory.getLogger(shelterController.class);
	@PostConstruct
	public List<shelterVO> getNewsDatas() throws IOException {
        List<shelterVO> newsList = new ArrayList<>();
		/*
		 * System.setProperty("webdriver.chrome.driver",
		 * "C:\\Users\\민경준\\Desktop\\chromedriver_win32\\chromedriver.exe"); WebDriver
		 * driver = new ChromeDriver(); driver.get(URL); WebElement element =
		 * driver.findElement(By.className("vcshc")); element.click(); driver.quit();
		 */
        
        Document document = Jsoup.connect(URL).get();

        Elements contents = document.select("section ul.R1Lzz li");

        for (Element content : contents) {
        	shelterVO shelter = shelterVO.builder()
                    .subject(content.select("span.place_bluelink").text())		// 제목
                    .url(content.select("div div a").attr("abs:href"))		// 링크
                    .location(content.select("span.Q8Zql").text())		// 위치
                    .address(content.select("div.MaJkh  div.o8CtQ").text())		// 도로명
                    .build();
            newsList.add(shelter);
        }
        logger.debug("<<크롤링 service 리스트>> : " + newsList);
        return newsList;
	}
}
