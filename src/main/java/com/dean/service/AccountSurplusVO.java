package com.dean.service;

/**
 * Created by dongxu on 2017/3/3.
 */
public class AccountSurplusVO {
    private Long userId;
    private int surplus;
    private String timeMenu;
    private String typeMenu;

    public int getSurplus() {
        return surplus;
    }

    public void setSurplus(int surplus) {
        this.surplus = surplus;
    }

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

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

}
