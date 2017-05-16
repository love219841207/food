package com.dean.config.fiter;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * Created by dongxu on 2017/5/4.
 */
@Configuration
public class WehcatWebMvcConfigurerAdapter extends WebMvcConfigurerAdapter {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new WechatInterceptor())
                .addPathPatterns("/**").excludePathPatterns("/short/**","/wechat/**","/book/group**","/dean/**");
        super.addInterceptors(registry);
    }
}
