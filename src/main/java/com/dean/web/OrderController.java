package com.dean.web;

import com.dean.service.*;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
    @Autowired
    private CouponService couponService;
    @RequestMapping(value="/create/{type}/{timeType}/{pkgDays}")
    public String create(HttpServletRequest request,
                        ModelMap model,
                        @PathVariable("type") String type,
                        @PathVariable("timeType") String timeType,
                        @PathVariable("pkgDays") int pkgDays){
        logger.info("/create/{}/{}/{}", type, timeType, pkgDays);
        UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        OrderInfoVO orderInfoVO = orderService.createOrderInfo(type, timeType, userVO.getUserInfo().getId(), pkgDays);
        model.put("orderInfoVO", orderInfoVO);
        CouponVO couponVO = couponService.findByUserId(userVO.getUserInfo().getId());
        model.put("couponVO", couponVO);
        return "order/pay";
    }

    @RequestMapping(value="/charge")
    public String charge(OrderInfoVO orderInfoVO){
        logger.info("charge start id is [{}],couponId is [{}],remark is [{}]",orderInfoVO.getId(),orderInfoVO.getCouponId(),orderInfoVO.getRemark());
        orderService.chargeOrderInfo(orderInfoVO);
        return "forward:/fixed/index";
    }
}
