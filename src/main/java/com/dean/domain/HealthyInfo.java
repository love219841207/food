package com.dean.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by dongxu on 2017/5/10.
 */
@Entity
@Table(name="healthy_info")
public class HealthyInfo {
    @Id
    @GeneratedValue
    private Long id;
    private Long userId;
    private Integer sex;
    private Date birthday;
    private Double height;
    private Double weight;
    private Integer activity;
    private Integer target;
    private Date last_update_time;

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

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Double getHeight() {
        return height;
    }

    public void setHeight(Double height) {
        this.height = height;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public Integer getActivity() {
        return activity;
    }

    public void setActivity(Integer activity) {
        this.activity = activity;
    }

    public Integer getTarget() {
        return target;
    }

    public void setTarget(Integer target) {
        this.target = target;
    }

    public Date getLast_update_time() {
        return last_update_time;
    }

    public void setLast_update_time(Date last_update_time) {
        this.last_update_time = last_update_time;
    }

}
