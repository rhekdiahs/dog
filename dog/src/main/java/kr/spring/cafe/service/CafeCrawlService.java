package kr.spring.cafe.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.spring.cafe.vo.CafeCrawl;

@Service
public class CafeCrawlService {
	private static String Cafe_URL="https://search.daum.net/search?nil_suggest=btn&w=tot&DA=SBC&q=%EC%95%A0%EA%B2%AC%EC%B9%B4%ED%8E%98";
	private static final Logger logger = LoggerFactory.getLogger(CafeCrawlService.class);
	
	@PostConstruct
	 public List<CafeCrawl> getCafeCrawlDatas() throws IOException{
		List<CafeCrawl> cafeList = new ArrayList<>();
		
		Document document = Jsoup.connect(Cafe_URL).get();
		
		Elements contents = document.select("div ul.list_place li");
		
		for (Element content : contents) {
			CafeCrawl cafeCrawl = CafeCrawl.builder()
				                    .subject(content.select("a.fn_tit").text())		 // 제목
				                    .image(content.select("a.thumb_bf img").attr("abs:src")) // 이미지
				                    .url(content.select("div.inner_tit a").attr("abs:href")) // 링크
				                    .build();
            cafeList.add(cafeCrawl);
		}
		logger.debug("카페 크롤링 테스트 : " + cafeList);
		return cafeList;
		
	}
}
