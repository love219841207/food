package com.dean.web;

import com.dean.service.DeliveryAddressService;
import com.dean.service.DeliveryAddressVO;
import com.dean.service.UserAccountDetailService;
import com.dean.service.UserVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by dongxu on 2017/2/9.
 */
@Controller
@RequestMapping("/fixed")
public class FixedController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private DeliveryAddressService deliveryAddressService;
    @Autowired
    private UserAccountDetailService userAccountDetailService;
    @RequestMapping(value="/index")
    public String fixed(ModelMap model ,HttpServletRequest request,@RequestParam(value = "deliveryId",required = false) Long deliveryId){
        logger.info("/fixed/index");
        UserVO userVO = (UserVO)request.getSession().getAttribute("userVO");
        DeliveryAddressVO deliveryAddressVO = deliveryAddressService.getPlanDeliveryAddressVO(deliveryId,userVO.getUserInfo().getId());
        model.put("deliveryAddressVO",deliveryAddressVO);
        userAccountDetailService.findByUserId(userVO.getUserInfo().getId());
        return "fixed/index";
    }
}
