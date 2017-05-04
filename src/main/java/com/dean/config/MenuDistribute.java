package com.dean.config;

import org.springframework.util.StringUtils;

/**
 * Created by dongxu on 2017/2/9.
 */
public class MenuDistribute {
    public static String distribute(String routeid){
        if (!StringUtils.isEmpty(routeid)) {
            if (routeid.equals("1")) {
                return "forward:/user/index";
            } else if (routeid.equals("2")) {
                return "forward:/fixed/index";
            }else if (routeid.equals("3")) {
                return "forward:/book/single";
            }else if (routeid.equals("4")) {
                return "forward:/book/group";
            }
        }
        return "forward:/user/home";
    }
}
