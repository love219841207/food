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
                           @PathVariable("routeid") Integer routeid,
                           ModelMap model){
        logger.info("入口路由id为[{}]",routeid==null?"1":routeid);
        String cid = request.getParameter("cid");
        logger.info("入口路由cid为[{}]",cid);
        //获取openid
        String code = request.getParameter("code");
        logger.info("个人中心进入，code为[{}]",code);
        String openid = wechatService.getOpenid(code);
        logger.info("个人中心进入，获取的openid为[{}]", openid);
        UserVO userVO = null;
        if(routeid<11){
            userVO = userService.getUserVOByOpenId("oPBel0o4oOxDFVh1Z_WS1IjEBvPk");
            //userVO = userService.getUserVOByOpenId(openid);
        }else{
            userVO = userService.getUserVOByOpenId("oPBel0o4oOxDFVh1Z_WS1IjEBvPk","23");
            //userVO = userService.getUserVOByOpenId(openid,cid);
        }
        logger.info("个人中心进入，根据openid获取UserVO[{}]", userVO != null);
        if(userVO!=null){
            request.getSession().setAttribute(Constants.SESSION_USER_KEY, userVO);

            //B2C
            if(routeid<11){
                if(userVO.getUserInfo()==null){
                    model.put("routeid",routeid);
                    logger.info("进入手机号码绑定页面");
                    return "wechat/binding";
                }else{
                    return distribute(routeid,null);
                }
                //B2B
            }else{
                if(userVO.getGroupUserInfo()==null){
                    model.put("routeid",routeid);
                    model.put("cid",cid);
                    logger.info("进入团体绑定页面");
                    return "wechat/groupBinding";
                }else{
                    return distribute(routeid,cid);
                }
            }


        }else{
            if(routeid<11){
                return "forward:/short/"+routeid;
            }else{
                return "forward:/short/"+routeid+"/"+cid;
            }

        }
    }

    @RequestMapping("/binding/{phone}/{routeid}")
    public String binding(HttpServletRequest request,
                          @PathVariable String phone,
                          @PathVariable Integer routeid) {
        UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        String openId = userVO.getWechatInfo().getOpenId();
        userVO = userService.BoundUser(phone, openId);
        request.getSession().setAttribute(Constants.SESSION_USER_KEY, userVO);
        return distribute(routeid,null);
    }

    private String distribute(Integer routeid,String cid){
        Integer companyId = null;
        if(!StringUtils.isEmpty(cid)){
            companyId = Integer.valueOf(cid);
        }
        return MenuDistribute.distribute(routeid,companyId);
    }
}
