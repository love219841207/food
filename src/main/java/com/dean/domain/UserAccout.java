package com.dean.domain;

/**
 * Created by dongxu on 2017/2/28.
 */
public class UserAccout {
    private Long id;
    private Long userId;
    private int noonSurplus;
    private int nightSurplus;

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
