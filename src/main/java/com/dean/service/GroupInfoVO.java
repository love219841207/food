package com.dean.service;

import java.util.Date;

/**
 * Created by dongxu on 2017/2/10.
 */
public class GroupInfoVO {
    private Long id;
    private String groupName;
    private String name;
    private String phone;
    private String remark;
    private Long wechatId;
    private Integer status;

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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
