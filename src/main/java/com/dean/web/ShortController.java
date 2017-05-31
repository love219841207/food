package com.dean.web;

import com.dean.config.MenuDistribute;
import com.dean.config.WechatRouteProperties;
import com.dean.service.UserVO;
import com.dean.service.WechatService;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private WechatService wechatService;
    @Autowired
    private WechatRouteProperties appUrlProperties;
    private String URL_REDIRECT_PREFIX = "redirect:";
    @RequestMapping(value="/short/{id}")
    public String redirect(@PathVariable("id") Integer id){
        logger.info("进入主菜单模式[{}]",id);
        String url = this.getRedirect(String.valueOf(id));
        return url;
    }

    @RequestMapping(value="/short/{id}/{cid}")
    public String redirect(@PathVariable("id") Integer id,
                           @PathVariable("cid") Integer cid){
        logger.info("进入公司员工订餐模式[{}]",id,cid);
        String url = this.getRedirect(id + "?cid=" + cid);
        return url;
    }

    private String getRedirect(String id){
        String url = String.format(appUrlProperties.getAuthUrl(), id);
        url = URL_REDIRECT_PREFIX+wechatService.getRedirUrl(url);
        return url;
    }
}
