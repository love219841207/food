package com.dean.web;

import com.dean.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by dongxu on 2017/1/24.
 */
@Controller
@RequestMapping("/")
public class LoginController {
    @Autowired
    private UserService userService;
    @RequestMapping("/index")
    public String index(){
        userService.createUser();
        return "user/index";
    }
}
