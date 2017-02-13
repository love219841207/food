package com.dean.config.fiter;


import com.dean.service.UserVO;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by dongxu on 2017/2/9.
 */
public class WechatSecurityInterceptor implements HandlerInterceptor {
    private Logger logger  = LoggerFactory.getLogger(getClass());
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        UserVO userVO = null;
        if(request.getSession().getAttribute(Constants.SESSION_USER_KEY)!=null){
            logger.info("WechatSecurityInterceptor,session不为空");
        }else{
            logger.info("WechatSecurityInterceptor,session为空");
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
