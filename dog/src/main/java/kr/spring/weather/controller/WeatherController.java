package kr.spring.weather.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class WeatherController {
	
	private static final Logger logger = LoggerFactory.getLogger(WeatherController.class);
	
	@Value("${property.key.weatherkey}")
	private String apiKey;
	
	@GetMapping("/weather/weather.do")
    public String from(Model model) throws Exception{
		
		model.addAttribute("key", apiKey);
        return "weather";
    }
	
}
