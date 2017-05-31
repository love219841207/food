package com.dean.config;

import org.springframework.util.StringUtils;

/**
 * Created by dongxu on 2017/2/9.
 */
public class MenuDistribute {
    public static String distribute(Integer routeid,Integer cid){
        if (!StringUtils.isEmpty(routeid)) {
            if (routeid==1) {
                return "forward:/user/index";
            } else if (routeid==2) {
                return "forward:/fixed/index";
            }else if (routeid==3) {
                return "forward:/book/single";
            }else if (routeid==4) {
                return "forward:/book/group";
            }else if(routeid==11){
                return "forward:/book/reserve/"+cid;
            }
        }
        return "forward:/user/home";
    }
}
