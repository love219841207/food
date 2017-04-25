package com.dean.web;

import com.dean.service.CouponService;
import com.dean.service.UserService;
import com.dean.service.UserVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by dongxu on 2017/1/24.
 */
@Controller
@RequestMapping("/user")
public class UserController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
   /* @Autowired
    private UserService userService;*/
    @Autowired
    private CouponService couponService;

    @RequestMapping("/index")
    public String index(HttpServletRequest request,ModelMap model){
        UserVO userVO = (UserVO)request.getSession().getAttribute("userVO");
        Integer couponCount = couponService.findCountByUserId(userVO.getUserInfo().getId());
        model.put("couponCount",couponCount);
        return "user/index";
    }
}
