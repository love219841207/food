package com.dean.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Created by dongxu on 2017/6/5.
 */
@ConfigurationProperties(prefix = "spring.wechat.zxing")
public class ZxingProperties {
    private String groupUrl;
    private String filePath;

    public String getGroupUrl() {
        return groupUrl;
    }

    public void setGroupUrl(String groupUrl) {
        this.groupUrl = groupUrl;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}
