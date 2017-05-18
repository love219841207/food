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
 * Created by dongxu on 2017/5/4.
 */
public class WechatInterceptor implements HandlerInterceptor {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        boolean boo = false;
        UserVO userVO = (UserVO)httpServletRequest.getSession().getAttribute(Constants.SESSION_USER_KEY);
        if(userVO!=null){
            boo = true;
        }
        logger.info("拦截器了url [{}][{}]",httpServletRequest.getRequestURL(),boo);
        return boo;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
