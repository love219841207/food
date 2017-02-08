package com.dean.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Created by dongxu on 2017/2/1.
 */
@ConfigurationProperties(prefix = "spring.wechat.appurl")
public class AppUrlProperties {
    private String userinfo;

    public String getUserinfo() {
        return userinfo;
    }

    public void setUserinfo(String userinfo) {
        this.userinfo = userinfo;
    }
}
