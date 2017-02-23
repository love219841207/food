package com.dean.web;

import com.dean.service.*;
import com.dean.util.BaseUtil;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

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
    @Autowired
    private WechatService wechatService;

    private static final String LOCALURL = "order/create";
    @RequestMapping(value="/create")
     public String create(HttpServletRequest request,
                          ModelMap model,
                          @RequestParam(value = "type") String type,
                          @RequestParam(value = "timeMenu") String timeMenu,
                          @RequestParam(value = "pkgDays") int pkgDays){
        logger.info("/create/{}/{}/{}", type, timeMenu, pkgDays);
        UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        OrderInfoVO orderInfoVO = orderService.createOrderInfo(type, timeMenu, userVO.getUserInfo().getId(), pkgDays);
        model.put("orderInfoVO", orderInfoVO);
        CouponVO couponVO = couponService.findByUserId(userVO.getUserInfo().getId());
        model.put("couponVO", couponVO);
        return "order/bill";
    }

    @RequestMapping(value="/payment")
    public String payment(HttpServletRequest request,OrderInfoVO orderInfoVO){
        orderService.chargeOrderInfo(orderInfoVO);
        return "forward:/fixed/index";

    }

    @RequestMapping("/charge")
    @ResponseBody
    public Map paymentAjax(HttpServletRequest request,OrderInfoVO orderInfoVO){
        orderService.checkOrderInfo(orderInfoVO);
        Map map  = new HashMap();
        WxConfig config = wechatService.createWxConfig(LOCALURL);
        map.put("config", config);
        UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        String openId = userVO.getWechatInfo().getOpenId();//session获取自己的openid
        String orderId = orderInfoVO.getId();//"获取自己商城的订单id"
        String ip ="8.8.8.8";//获取请求的ip
        int fee = 1;//单位分
        String body = "商品名称";
        String attach = "test";
        PayConfig pconfig = wechatService.createPayConfig(openId, orderId,attach,body, ip, fee, config);
        map.put("pconfig", pconfig);
        return map;
    }
}
