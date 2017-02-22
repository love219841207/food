package com.dean.web;

import com.dean.service.OrderInfoVO;
import com.dean.service.OrderService;
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
 * Created by dongxu on 2017/2/21.
 */
@RequestMapping(value="/order")
@Controller
public class OrderController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private OrderService orderService;
    @RequestMapping(value="/create/{type}/{timeType}/{pkgDays}")
    public String fixed(HttpServletRequest request,
                        @PathVariable("type") String type,
                        @PathVariable("timeType") String timeType,
                        @PathVariable("pkgDays") int pkgDays){
        logger.info("/create/{}/{}/{}", type, timeType, pkgDays);
        UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        OrderInfoVO orderInfoVO = orderService.createOrderInfo(type,timeType,userVO.getUserInfo().getId(),pkgDays);
        return "order/create";
    }
}
