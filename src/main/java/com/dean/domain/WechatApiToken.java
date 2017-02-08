package com.dean.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by dongxu on 2017/2/8.
 */
@Entity
@Table(name="wechat_api_token")
public class WechatApiToken {
    @Id
    @GeneratedValue
    private Long id;
    private String accessToken;
    private Date updateTime;

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
        refreshUpdateTime();
    }

    private void refreshUpdateTime(){
        this.updateTime = new Date();
    }
}
