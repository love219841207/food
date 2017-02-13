package com.dean.config;

import org.springframework.util.StringUtils;

/**
 * Created by dongxu on 2017/2/9.
 */
public class MenuDistribute {
    public static String distribute(String routeid){
        if (!StringUtils.isEmpty(routeid)) {
            if (routeid.equals("1")) {
                return "redirect:/user/index";
            } else if (routeid.equals("2")) {
                return "redirect:/fixed/index";
            }else if (routeid.equals("3")) {
                return "redirect:/book/single";
            }else if (routeid.equals("4")) {
                return "redirect:/book/group";
            }
        }
        return "redirect:/user/home";
    }
}
