package com.dean.service;

import java.util.Date;

/**
 * Created by dongxu on 2017/6/6.
 */
public class GroupUserInfoVO {
    private Long id;
    private Long wechatId;
    private String name;
    private Long cid;
    private String dep;
    private Date createTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getWechatId() {
        return wechatId;
    }

    public void setWechatId(Long wechatId) {
        this.wechatId = wechatId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getCid() {
        return cid;
    }

    public void setCid(Long cid) {
        this.cid = cid;
    }

    public String getDep() {
        return dep;
    }

    public void setDep(String dep) {
        this.dep = dep;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
