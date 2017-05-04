package com.dean.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by dongxu on 2017/5/3.
 */
@Controller
@RequestMapping("/test")
public class TestController {
    @RequestMapping("/a")
    public String a(HttpServletRequest request){
        System.out.println(request.getSession().getId());
        request.getSession().setAttribute("a", "a");
        return "forward:b";
    }
    @RequestMapping("/b")
    public String b(HttpServletRequest request){
        System.out.println(request.getSession().getId());
        request.getSession().setAttribute("a","a");
        return "test/b";
    }
}
