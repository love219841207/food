package com.dean.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by dongxu on 2017/3/2.
 */
@Entity
@Table(name="user_account_detail")
public class UserAccountDetail {
    @Id
    @GeneratedValue
    private Long id;
    private Long userId;
    private Date happenTime;
    private int type;
    private String orderId;
    private String fixId;
    private String timeMenu;
    private String typeMenu;
    private int num;

    public String getTimeMenu() {
        return timeMenu;
    }

    public void setTimeMenu(String timeMenu) {
        this.timeMenu = timeMenu;
    }

    public String getTypeMenu() {
        return typeMenu;
    }

    public void setTypeMenu(String typeMenu) {
        this.typeMenu = typeMenu;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Date getHappenTime() {
        return happenTime;
    }

    public void setHappenTime(Date happenTime) {
        this.happenTime = happenTime;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getFixId() {
        return fixId;
    }

    public void setFixId(String fixId) {
        this.fixId = fixId;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
}
