package com.dean.config.fiter;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;


/**
 * Created by dongxu on 2017/2/9.
 */
/*@Configuration*/
public class WebWechatConfig extends WebMvcConfigurerAdapter {

    @Bean
    public WechatSecurityInterceptor getWechatSecurityInterceptor() {
        return new WechatSecurityInterceptor();
    }
    /**
     * Created by dongxu on 2017/2/1.
     */
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(getWechatSecurityInterceptor())
                .excludePathPatterns("/error")
                .excludePathPatterns("/css/**")
                .excludePathPatterns("/date/**")
                .excludePathPatterns("/img/**")
                .excludePathPatterns("/js/**")
                .addPathPatterns("/**");
    }
}

