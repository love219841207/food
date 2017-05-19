package com.dean.service;

import com.dean.util.DateUtils;

import java.util.Date;

/**
 * Created by dongxu on 2017/5/19.
 */
public class ChooseDayVO {
    private String chooseDay;
    private String chooseDayAlias;
    private String ychooseDay;
    private String ychooseDayAlias;
    private boolean enable;
    private String tchooseDay;
    private String tchooseDayAlias;

    public ChooseDayVO(String chooseDay){
        Date d = DateUtils.getDate(chooseDay);
        setChooseDay(chooseDay);
        //设置选择日期的别名
        setChooseDayAlias(DateUtils.getShortStringDate(d));
        Date yd = DateUtils.getSpecifiedDayBefore(d, -1);
        setYchooseDay(DateUtils.getStringDate(yd));
        setYchooseDayAlias(DateUtils.getShortStringDate(yd));
        setEnable(yd.after(new Date()));
        Date td = DateUtils.getSpecifiedDayBefore(d, 1);
        setTchooseDay(DateUtils.getStringDate(td));
        setTchooseDayAlias(DateUtils.getShortStringDate(td));
    }
    public boolean getEnable() {
        return enable;
    }

    public void setEnable(boolean enable) {
        this.enable = enable;
    }

    public String getChooseDay() {
        return chooseDay;
    }

    public void setChooseDay(String chooseDay) {
        this.chooseDay = chooseDay;
    }

    public String getChooseDayAlias() {
        return chooseDayAlias;
    }

    public void setChooseDayAlias(String chooseDayAlias) {
        this.chooseDayAlias = chooseDayAlias;
    }

    public String getYchooseDay() {
        return ychooseDay;
    }

    public void setYchooseDay(String ychooseDay) {
        this.ychooseDay = ychooseDay;
    }

    public String getYchooseDayAlias() {
        return ychooseDayAlias;
    }

    public void setYchooseDayAlias(String ychooseDayAlias) {
        this.ychooseDayAlias = ychooseDayAlias;
    }

    public String getTchooseDay() {
        return tchooseDay;
    }

    public void setTchooseDay(String tchooseDay) {
        this.tchooseDay = tchooseDay;
    }

    public String getTchooseDayAlias() {
        return tchooseDayAlias;
    }

    public void setTchooseDayAlias(String tchooseDayAlias) {
        this.tchooseDayAlias = tchooseDayAlias;
    }
}
