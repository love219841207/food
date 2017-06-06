package com.dean.service;

import java.util.Date;

/**
 * Created by dongxu on 2017/6/6.
 */
public class GroupOrderVO {
    private Long id;
    private Long groupUserId;
    private Integer av;
    private Integer bv;
    private Date bookDay;
    private Date createTime;
    private Date updateTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getGroupUserId() {
        return groupUserId;
    }

    public void setGroupUserId(Long groupUserId) {
        this.groupUserId = groupUserId;
    }

    public Integer getAv() {
        return av;
    }

    public void setAv(Integer av) {
        this.av = av;
    }

    public Integer getBv() {
        return bv;
    }

    public void setBv(Integer bv) {
        this.bv = bv;
    }

    public Date getBookDay() {
        return bookDay;
    }

    public void setBookDay(Date bookDay) {
        this.bookDay = bookDay;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
