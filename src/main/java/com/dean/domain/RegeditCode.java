package com.dean.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by dongxu on 2017/1/27.
 */
@Entity
@Table(name="user_regedit_code")
public class RegeditCode {
    @Id
    @GeneratedValue
    private Long id;
    private String code;
    private String phone;
    private Date createTime;
    private String openId;
    private int scene;

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }



    public int getScene() {
        return scene;
    }

    public void setScene(int scene) {
        this.scene = scene;
    }
}
