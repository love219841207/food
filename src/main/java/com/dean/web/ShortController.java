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
    public String redirect(@PathVariable("id") String id,HttpSession session){
        logger.info("进入主菜单模式[{}]",id);
     //   Object o = session.getAttribute(Constants.SESSION_USER_KEY);
        UserVO userVO = (UserVO)session.getAttribute(Constants.SESSION_USER_KEY);
        logger.info("userVO是否为null[{}]",userVO==null);
        String url = null;
        if(userVO==null || userVO.getWechatInfo()==null){
            url = String.format(appUrlProperties.getAuthUrl(), id);
            url = URL_REDIRECT_PREFIX+wechatService.getRedirUrl(url);
        }else{
            url =distribute(id);
        }

        return url;
    }

    private String distribute(String routeid){
        return MenuDistribute.distribute(routeid);
    }
}
