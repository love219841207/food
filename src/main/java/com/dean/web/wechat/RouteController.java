package com.dean.web.wechat;

import com.dean.config.MenuDistribute;
import com.dean.domain.UserInfo;
import com.dean.service.UserService;
import com.dean.service.UserVO;
import com.dean.service.WechatService;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by dongxu on 2017/2/9.
 */
@Controller
@RequestMapping("/wechat")
public class RouteController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private UserService userService;
    @Autowired
    private WechatService wechatService;
    @RequestMapping(value="/route/{routeid}")
    public String redirect(HttpServletRequest request,
                           @PathVariable("routeid") String routeid,
                           ModelMap model){
        logger.info("入口路由id为[{}]",StringUtils.isEmpty(routeid)?"1":routeid);
        //获取openid
        String code = request.getParameter("code");
        logger.info("个人中心进入，code为[{}]",code);
        String openid = wechatService.getOpenid(code);
        logger.info("个人中心进入，获取的openid为[{}]", openid);
        UserVO userVO = userService.getUserVOByOpenId(openid);
        logger.info("个人中心进入，根据openid获取UserVO[{}]", userVO !=null);
        if(userVO!=null){
            request.getSession().setAttribute(Constants.SESSION_USER_KEY, userVO);
            if(userVO.getUserInfo()==null){
                model.put("routeid",routeid);
                logger.info("进入手机号码绑定页面");
                return "wechat/binding";
            }else{
                return distribute(routeid);
            }
        }else{
            return "forward:/short/"+routeid;
        }
    }

    @RequestMapping("/binding/{phone}/{routeid}")
    public String binding(HttpServletRequest request,
                          @PathVariable String phone,
                          @PathVariable String routeid) {
        UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        String openId = userVO.getWechatInfo().getOpenId();
        userVO = userService.BoundUser(phone, openId);
        request.getSession().setAttribute(Constants.SESSION_USER_KEY, userVO);
        return distribute(routeid);
    }

    private String distribute(String routeid){
        return MenuDistribute.distribute(routeid);
    }
}
