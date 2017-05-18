package com.dean.web;

import com.dean.config.DateEditor;
import com.dean.config.MenuDistribute;
import com.dean.service.HealthyInfoService;
import com.dean.service.HealthyInfoVO;
import com.dean.service.UserVO;
import com.dean.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.swing.*;
import java.util.Date;

/**
 * Created by dongxu on 2017/5/9.
 */
@Controller
@RequestMapping("/healthy")
public class HealthyController {
    @InitBinder
    public void initBinder(WebDataBinder binder){
        binder.registerCustomEditor(Date.class, new DateEditor());
       // binder.registerCustomEditor(Double.class, new CustomNumberEditor(Double.class,true));
    }
    @Autowired
    private HealthyInfoService healthyInfoService;
    @RequestMapping("/info")
    public String info(HttpServletRequest request,ModelMap model){
        UserVO userVO = (UserVO)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        HealthyInfoVO healthyInfoVO = healthyInfoService.getHealthyInfoVO(userVO.getUserInfo().getId());
        model.put("healthyInfoVO",healthyInfoVO);
        return "healthy/info";
    }

    @RequestMapping("/save")
    public String save(HttpServletRequest request,HealthyInfoVO healthyInfoVO){
        healthyInfoService.save(healthyInfoVO);
        return MenuDistribute.distribute("3");
    }
}
