package com.dean.web;

import com.dean.config.WechatRouteProperties;
import com.dean.service.WechatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * Created by dongxu on 2017/2/1.
 */
@Controller
@EnableConfigurationProperties(WechatRouteProperties.class)
public class ShortController {
    @Autowired
    private WechatService wechatService;
    @Autowired
    private WechatRouteProperties appUrlProperties;
    private String URL_REDIRECT_PREFIX = "redirect:";
    @RequestMapping(value="/short/{id}")
    public String redirect(@PathVariable("id") String id,HttpSession session){
        String url = String.format(appUrlProperties.getAuthUrl(), id);
        url = URL_REDIRECT_PREFIX+wechatService.getRedirUrl(url);
        return url;
    }
}
