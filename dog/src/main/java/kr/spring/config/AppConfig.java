package kr.spring.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
//import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import kr.spring.interceptor.AdminCheckInterceptor;
import kr.spring.interceptor.AutoLoginCheckInterceptor;
import kr.spring.interceptor.LoginCheckInterceptor;
//자바코드 기반 설정 클래스
@Configuration
public class AppConfig implements WebMvcConfigurer{
	
	private AutoLoginCheckInterceptor autoLogin;
	private LoginCheckInterceptor loginCheck;
	private AdminCheckInterceptor adminCheck;

	
	@Bean
	public AutoLoginCheckInterceptor interceptor() {
		autoLogin = new AutoLoginCheckInterceptor();
		return autoLogin;
	}
	
	@Bean
	public LoginCheckInterceptor interceptor2() {
		loginCheck = new LoginCheckInterceptor();
		return loginCheck;
	}
	
	@Bean
	public AdminCheckInterceptor interceptor3() {
		adminCheck = new AdminCheckInterceptor();
		return adminCheck;
	}
	
	
	//인터셉터 등록
		@Override
		public void addInterceptors(InterceptorRegistry registry) {
			//AutoLoginCheckInterceptor 설정
			registry.addInterceptor(autoLogin).addPathPatterns("/**") //모든 경로
											  .excludePathPatterns("/member/login.do") //제외할 화면
											  .excludePathPatterns("/member/logout.do"); //제외할 화면
			//LoginCheckInterceptor 설정
			registry.addInterceptor(loginCheck).addPathPatterns("/community/lostList.do");
			//AdminCheckInterceptor 설정
			registry.addInterceptor(adminCheck)
					.addPathPatterns("/main/admin.do")
					.addPathPatterns("/admin/adminMain.do")
					.addPathPatterns("/admin/adminMember.do")
					.addPathPatterns("/admin/admincafe.do");
		}

	//타일스 설정
	@Bean
	public TilesConfigurer tilesConfigurer() {
		final TilesConfigurer configurer =
				new TilesConfigurer();
		//해당 경로에 xml 설정 파일을 넣음
		configurer.setDefinitions(new String[] {
				"/WEB-INF/tiles-def/main.xml",
				"/WEB-INF/tiles-def/YM.xml",
				"/WEB-INF/tiles-def/HJ.xml",
				"/WEB-INF/tiles-def/KJ.xml",
				"/WEB-INF/tiles-def/KY.xml"
		});
		configurer.setCheckRefresh(true);
		return configurer;
	}
	@Bean
	public TilesViewResolver tilesViewResolver() {
		final TilesViewResolver tilesViewResolver = 
				new TilesViewResolver();
		tilesViewResolver.setViewClass(TilesView.class);
		return tilesViewResolver;
	}
	
	/*
	 * @Bean public JavaMailSenderImpl javaMailSenderImpl() { Properties prop = new
	 * Properties(); prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	 * prop.put("mail.smtp.starttls.enable", "true");
	 * prop.put("mail.transport.protocol", "smtp"); prop.put("mail.smtp.auth",
	 * "true"); prop.put("mail.debug", "true");
	 * 
	 * JavaMailSenderImpl javaMail = new JavaMailSenderImpl();
	 * javaMail.setHost("smtp.gmail.com"); javaMail.setPort(587);
	 * javaMail.setDefaultEncoding("utf-8");
	 * javaMail.setUsername("ourstudy421@gmail.com");
	 * javaMail.setPassword("fttenxtxayyznnki");
	 * javaMail.setJavaMailProperties(prop); return javaMail; }
	 */
}