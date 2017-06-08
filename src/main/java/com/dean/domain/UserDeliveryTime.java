package com.dean.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by dongxu on 2017/6/8.
 */
@Entity
@Table(name="user_delivery_time")
public class UserDeliveryTime {
    @Id
    @GeneratedValue
    private Long id;
    private Long userId;
    private String nnTime;
    private String ntTime;

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

    public String getNnTime() {
        return nnTime;
    }

    public void setNnTime(String nnTime) {
        this.nnTime = nnTime;
    }

    public String getNtTime() {
        return ntTime;
    }

    public void setNtTime(String ntTime) {
        this.ntTime = ntTime;
    }
}
