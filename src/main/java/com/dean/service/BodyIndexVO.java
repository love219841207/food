package com.dean.service;

/**
 * Created by dongxu on 2017/5/10.
 */
public class BodyIndexVO {
    private Long userId;
    private Double bmi;
    private String bmiLevel;
    private Double metabolize;
    private Double consume;
    private Double caloricReq;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Double getBmi() {
        return bmi;
    }

    public void setBmi(Double bmi) {
        this.bmi = bmi;
    }

    public String getBmiLevel() {
        return bmiLevel;
    }

    public void setBmiLevel(String bmiLevel) {
        this.bmiLevel = bmiLevel;
    }

    public Double getMetabolize() {
        return metabolize;
    }

    public void setMetabolize(Double metabolize) {
        this.metabolize = metabolize;
    }

    public Double getConsume() {
        return consume;
    }

    public void setConsume(Double consume) {
        this.consume = consume;
    }

    public Double getCaloricReq() {
        return caloricReq;
    }

    public void setCaloricReq(Double caloricReq) {
        this.caloricReq = caloricReq;
    }
}
