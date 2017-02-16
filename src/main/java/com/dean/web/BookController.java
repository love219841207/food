package com.dean.web;
import com.dean.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;


/**
 * Created by dongxu on 2017/2/9.
 */

@Controller
@RequestMapping("/book")
public class BookController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private UserService userService;
    @Autowired
    private GroupInfoService groupInfoService;
    @Autowired
    private MenuService menuService;
    @RequestMapping("/group")
    public String group(){
       return "book/group";
    }

    @RequestMapping("/groupsub")
    public String groupsub(GroupInfoVO groupInfoVO){
        groupInfoService.saveGroupInfo(groupInfoVO);
        return "book/groupsuccess";
    }

    @RequestMapping("/single")
    public String single(ModelMap model) {
        List<TypeMenuVO> list = menuService.findTypeMenu();
        model.put("typeMenus", list);
        return "book/single";
    }
    @RequestMapping("/typemenu/{type}")
    private String typemenu(@PathVariable("type") String type){
        logger.info("进入套餐详情页面,type为[{}]",type);
        return "book/details";

    }
}
