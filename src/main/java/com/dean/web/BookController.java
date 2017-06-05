package com.dean.web;
import com.dean.service.*;
import com.dean.util.Constants;
import com.dean.util.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


/**
 * Created by dongxu on 2017/2/9.
 */

@Controller
@RequestMapping("/book")
public class BookController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    private final String DEFAULT_TIME_TYPE = "1";
    @Autowired
    private HealthyInfoService healthyInfoService;
    @Autowired
    private MenuService menuService;


    @RequestMapping("/single")
    public String single(ModelMap model,HttpServletRequest request) {
   /*     List<TypeMenuVO> list = menuService.findTypeMenu();
        model.put("typeMenus", list);*/
        UserVO userVO = (UserVO)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        BodyIndexVO bodyIndexVO = healthyInfoService.getBodyIndexVO(userVO.getUserInfo().getId());
        model.put("bodyIndexVO",bodyIndexVO);
        logger.info("book/single seesion[{}]", request.getSession().getId());
        return "book/single";
    }
    @RequestMapping(value="/typemenu/{type}")
    private String typemenu(@PathVariable("type") String type,
                            @RequestParam(value = "timeType",required = false) String timeType,
                            @RequestParam(value = "chooseDay", required = false) String chooseDay,
                            ModelMap model) {
        logger.info("进入套餐详情页面,type为[{}],timeType为[{}],day为[{}]",type,timeType,chooseDay);
        if(StringUtils.isEmpty(timeType)){
            timeType = DEFAULT_TIME_TYPE;
        }
        if (StringUtils.isEmpty(chooseDay)){
            chooseDay = DateUtils.getStringDay(1);
        }
        logger.info("init套餐详情页面,type为[{}],timeType为[{}],day为[{}]", type, timeType, chooseDay);

        List<MenuInfoVO> menus = menuService.findMenuDetail(chooseDay, type);
        model.put("menus",menus);
        model.put("type", type);
        model.put("timeType",timeType);
        model.put("chooseDayVO", new ChooseDayVO(chooseDay));
        return "book/details";

    }

}
