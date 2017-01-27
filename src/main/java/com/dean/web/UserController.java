package com.dean.web;

import com.dean.service.SmsService;
import com.dean.service.UserService;
import com.dean.service.UserVO;
import com.dean.service.WechatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by dongxu on 2017/1/24.
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private WechatService wechatService;

    @RequestMapping("/index")
    public String index(HttpServletRequest request){
        //--TODO获取openid
        String openId = wechatService.getOpenId("code");
        UserVO userVO = userService.getUserVOByOpenId(openId);
        request.getSession().setAttribute("userVO",userVO);
        if(userVO.getUserInfo()==null){
            return "user/binding";
        }else{
            return "user/index";
        }


    }
}
