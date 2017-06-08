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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;

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
    @Autowired
    private UserDeliveryTimeService userDeliveryTimeService;

    @RequestMapping("/time/{timemenu}")
    public String time(@PathVariable("timemenu") String timemenu,
                       ModelMap model,HttpServletRequest request){
        logger.info("/time/index,timemenu[{}]",timemenu);
        UserVO userVO = (UserVO)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        UserDeliveryTimeVO userDeliveryTimeVO = userDeliveryTimeService.findByUserId(userVO.getUserInfo().getId());
        model.put("userDeliveryTimeVO",userDeliveryTimeVO);
        model.put("timemenu",timemenu);
        if(timemenu.equals(Constants.TIME_MENU_NOON)){
            model.put("slev",userDeliveryTimeVO.getNnTime());
        }else{
            model.put("slev",userDeliveryTimeVO.getNtTime());
        }
        return "fixed/time";
    }
    @RequestMapping("/time/seltime")
    public String seltime(@RequestParam(value = "timemenu",required = false) String timemenu,
                          UserDeliveryTimeVO userDeliveryTimeVO,
                          @RequestParam(value = "slev",required = false) String slev){
        userDeliveryTimeService.saveUserDeliveryTimeVO(userDeliveryTimeVO,timemenu,slev);
        return "forward:/fixed/index";
    }

    @RequestMapping(value="/index")
    public String fixed(ModelMap model ,HttpServletRequest request,@RequestParam(value = "deliveryId",required = false) Long deliveryId){
        logger.info("/fixed/index,deliveryId[{}]",deliveryId);
        UserVO userVO = (UserVO)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        logger.info("userVO[{},{}]", userVO==null,request.getSession().getId());
        logger.info("userVO[{}]" ,userVO.getUserInfo().getId());
        DeliveryAddressVO deliveryAddressVO = deliveryAddressService.getPlanDeliveryAddressVO(deliveryId, userVO.getUserInfo().getId());
        model.put("deliveryAddressVO", deliveryAddressVO);
        List<AccountSurplusVO> surplusList =  userAccountDetailService.findSurplus(userVO.getUserInfo().getId());
        List<AccountFixedVO> fixedList = userAccountDetailService.findFixed(userVO.getUserInfo().getId());
        UserDeliveryTimeVO userDeliveryTimeVO = userDeliveryTimeService.findByUserId(userVO.getUserInfo().getId());
        model.put("surplusList",surplusList);
        model.put("fixedList",fixedList);
        model.put("userDeliveryTimeVO",userDeliveryTimeVO);
        return "fixed/index";
    }

    @RequestMapping(value="/save")
    @ResponseBody
    public String save(HttpServletRequest request) throws IOException {
        UserVO userVO = (UserVO)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        String str = this.convertStreamToString(request.getInputStream());
        userAccountDetailService.saveDetailfs(str,userVO.getUserInfo().getId());
        logger.info("排餐数据为:[{}]",str);
        return "OK";
    }

    private String convertStreamToString(InputStream is){
 /*
          * To convert the InputStream to String we use the BufferedReader.readLine()
          * method. We iterate until the BufferedReader return null which means
          * there's no more data to read. Each line will appended to a StringBuilder
          * and returned as String.
          */
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();

        String line = null;
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line + "\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return sb.toString();
    }
}
