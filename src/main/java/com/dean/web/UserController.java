package com.dean.web;

import com.dean.service.SmsService;
import com.dean.service.UserService;
import com.dean.service.UserVO;
import com.dean.service.WechatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by dongxu on 2017/1/24.
 */
@Controller
@RequestMapping("/user")
public class UserController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private UserService userService;
    @Autowired
    private WechatService wechatService;

    @RequestMapping("/index")
    public String index(HttpServletRequest request/*,@RequestParam(value="code",required=false) String code*/){
        //--TODO获取openid
        String code = request.getParameter("code");
        logger.info("个人中心进入，code为[{}]",code);
        String openid = wechatService.getOpenid(code);
        logger.info("个人中心进入，获取的openid为[{}]", openid);
        UserVO userVO = userService.getUserVOByOpenId(openid);
        logger.info("个人中心进入，根据openid获取UserVO[{}]",userVO!=null);
        if(userVO!=null){
            logger.info("个人中心进入，放入session");
            request.getSession().setAttribute("userVO", userVO);
            logger.info("个人中心进入，{}", userVO.getUserInfo()==null);
            if(userVO.getUserInfo()==null){
                logger.info("个人中心进入页面[user/binding]");
                return "user/binding";
            }else{
                logger.info("个人中心进入页面[user/index]");
                return "user/home";
            }
        }else{
            return "error";
        }
    }

    @RequestMapping("/binding/{phone}")
    public String binding(HttpServletRequest request,
                          @PathVariable String phone) {
        UserVO userVO = (UserVO)request.getSession().getAttribute("userVO");
        String openId = userVO.getWechatInfo().getOpenId();
        userService.BoundUser(phone,openId);
        userVO = userService.getUserVOByOpenId(openId);
        request.getSession().setAttribute("userVO", userVO);
        return "user/home";
    }
}
