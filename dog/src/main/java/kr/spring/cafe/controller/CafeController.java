package kr.spring.cafe.controller;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.cafe.service.CafeCrawlService;
import kr.spring.cafe.service.CafeService;
import kr.spring.cafe.vo.CafeCrawl;
import kr.spring.cafe.vo.CafeVO;

@Controller
public class CafeController {
	private static final Logger logger = LoggerFactory.getLogger(CafeController.class);
	
	@Autowired
	private CafeService cafeService;
	
	@Autowired
	private CafeCrawlService cafeCrawlService;
	
	//자바빈 초기화
	@ModelAttribute
	public CafeVO initCommand() {
		return new CafeVO();
	}
	
	public CafeController(CafeCrawlService cafeCrawlService) {
		this.cafeCrawlService = cafeCrawlService;
	}
	
	
	//카페 지도
	@RequestMapping("/cafe/cafeMap.do")
	public String cafeMap(Model model, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();

		//카페 목록 개수
		int count = cafeService.selectCafeCount(map);

		model.addAttribute("count", count);

		return "cafeMap";

	}	

	//카페 크롤링 목록(jsoup)
	@GetMapping("/cafe/cafeList.do")
	public String cafeList(Model model) throws Exception{
		
		List<CafeCrawl> cafeCrawl = cafeCrawlService.getCafeCrawlDatas();
		logger.debug("<<카페 뜨나요?>> : " + cafeCrawl);
		model.addAttribute("CafeCrawl", cafeCrawl);
		
		return "cafeList";
		
	}
	
	
	/*
	//카페 크롤링 목록(selenium)
	@GetMapping("/cafe/cafeList.do")
	public String cafeList(){
		String url = "https://map.kakao.com/?q=애견카페";
		System.setProperty("webdriver.chrome.driver", "C:\\chromedriver_win32\\chromedriver.exe");
		
		WebDriver driver = new ChromeDriver();
		//WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));
		driver.get(url);
		
		List<WebElement> elements = driver.findElements(By.tagName("div.section ul.placelist li.PlaceItem"));
		for (WebElement element : elements) {
            System.out.println("----------------------------");
            System.out.println(element);	//⭐
        }
		
		return "cafeList";
	}
	*/
	
	/*
	  private WebDriver driver; //https://map.kakao.com/?q={keyword}
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
	  
	  @GetMapping("/cafe/cafeList.do") private List<CafeCrawl> getSelList() throws InterruptedException{
	  
		  List<CafeCrawl> list = new ArrayList<>();
		  
		  driver.get(url);
		  
		  Thread.sleep(1000);
		  
		  List<WebElement> cafeCrawl =
		  driver.findElements(By.tagName("div.section ul.placelist li.PlaceItem"));
		  	for (WebElement cafe : cafeCrawl) {
		  		String subject = cafe.findElement(By.tagName("div.head_item a.link_name")).getText();
		  		logger.debug("테스트 : "+subject);
		  	}
		  	return list;
		  }
	 */
	
}

