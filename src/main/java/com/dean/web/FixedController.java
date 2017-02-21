package com.dean.web;

import com.dean.service.UserService;
import com.dean.service.UserVO;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by dongxu on 2017/2/9.
 */
@Controller
@RequestMapping("/fixed")
public class FixedController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private UserService userService;

    @RequestMapping(value="/index/{type}/{timeType}/{pkgDays}")
    public String fixed(HttpServletRequest request,
                        @PathVariable("type") String type,
                        @PathVariable("timeType") String timeType,
                        @PathVariable("pkgDays") int pkgDays){
        logger.info("/index/{}/{}/{}",type,timeType,pkgDays);
        return "fixed/index";
    }
}
