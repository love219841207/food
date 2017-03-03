package com.dean.service;

/**
 * Created by dongxu on 2017/3/3.
 */
public class UserAccountVO {
    private Long userId;
    private int noonSurplus;
    private int nightSurplus;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public int getNoonSurplus() {
        return noonSurplus;
    }

    public void setNoonSurplus(int noonSurplus) {
        this.noonSurplus = noonSurplus;
    }

    public int getNightSurplus() {
        return nightSurplus;
    }

    public void setNightSurplus(int nightSurplus) {
        this.nightSurplus = nightSurplus;
    }
}
