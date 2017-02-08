package com.dean.web;

import com.dean.config.AppUrlProperties;
import com.dean.service.WechatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by dongxu on 2017/2/1.
 */
@Controller
@EnableConfigurationProperties(AppUrlProperties.class)
public class ShorController {
    @Autowired
    private WechatService wechatService;
    @Autowired
    private AppUrlProperties appUrlProperties;
    private String URL_REDIRECT_PREFIX = "redirect:";
    @RequestMapping(value="/short/{id}")
    public String redirect(@PathVariable("id") int id){
        String str = "";
        switch(id){
            case 1:
                str = URL_REDIRECT_PREFIX+wechatService.getRedirUrl(appUrlProperties.getUserinfo());
                break;
            case 2:
                str = "";
                break;
            default:
                str = "";
                break;

        }
        return str;

    }
}
