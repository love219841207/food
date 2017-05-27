package com.dean.web;

import com.dean.service.*;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
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
                          @RequestParam(value = "pkgDays") int pkgDays,
                          @RequestParam(value = "lp") BigDecimal lp){
        logger.info("/create/{}/{}/{}", type, timeMenu, pkgDays);
        UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        logger.info("session id [{}]",request.getSession().getId());
        OrderInfoVO orderInfoVO = orderService.initOrderInfo(type, timeMenu, userVO.getUserInfo().getId(), pkgDays,lp);
        model.put("orderInfoVO", orderInfoVO);
        CouponVO couponVO = couponService.findByUserId(userVO.getUserInfo().getId());
        model.put("couponVO", couponVO);
        return "order/bill";
    }

    @RequestMapping(value="/payment")
    public String payment(HttpServletRequest request,OrderInfoVO orderInfoVO,ModelMap model){
        orderService.payOrderInfo(orderInfoVO);
       /* UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        logger.info("userVO1[{},{}]", userVO == null, request.getSession().getId());
        List<OrderInfoVO> orders = orderService.getList(userVO.getUserInfo().getId());
        model.put("orders", orders);
        return "order/list";*/
       // logger.info("userVO1[{},{}]", userVO == null, request.getSession().getId());
        return "forward:list";
    }

    @RequestMapping(value="/list")
    public String list(HttpServletRequest request,ModelMap model){
        UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        logger.info("userVO2[{},{}]", userVO==null,request.getSession().getId());
        List<OrderInfoVO> orders = orderService.getList(userVO.getUserInfo().getId());
        model.put("orders",orders);
        return "order/list";

    }

    @RequestMapping("/charge")
    @ResponseBody
    public Map paymentAjax(HttpServletRequest request,OrderInfoVO orderInfoVO){
        orderInfoVO = orderService.createOrderInfo(orderInfoVO);
        Map map  = new HashMap();
        if(!StringUtils.isEmpty(orderInfoVO.getErrorMsg())){
            map.put("error_msg",orderInfoVO.getErrorMsg());
        }else{
            if(orderInfoVO.getStatus()==Constants.ORDER_STATUS_NOT_PAY){
                map.put("not_pay",true);
            }else{
                WxConfig config = wechatService.createWxConfig(LOCALURL);
                map.put("orderInfoVO", orderInfoVO);
                map.put("config", config);
                UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
                String openId = userVO.getWechatInfo().getOpenId();//session获取自己的openid
                String orderId = orderInfoVO.getId();//"获取自己商城的订单id"
                String ip ="8.8.8.8";//获取请求的ip
                BigDecimal lastPrice = orderInfoVO.getLastPrice();
                lastPrice = lastPrice.multiply(new BigDecimal(100));
                int fee = lastPrice.intValue();//单位分
                String body = "商品名称";
                String attach = "test";
                PayConfig pconfig = wechatService.createPayConfig(openId, orderId,attach,body, ip, fee, config);
                map.put("pconfig", pconfig);
            }
        }
        return map;
    }
}
