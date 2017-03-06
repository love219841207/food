package com.dean.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by dongxu on 2017/2/15.
 */
@Entity
@Table(name="schedule_menu_info")
public class ScheduleMenuInfo {
    @Id
    @GeneratedValue
    private Long id;
    private Date scheduleDay;
    private String typeMenu;
    private String timeMenu;
    private String mainInfo;
    private String minor;
    private String coarseGrain;
    private String stapleFood;
    private String drink;
    private String other;
    private String kcal;
    private String imgPaths;
    private Date updateTime;

    public String getImgPaths() {
        return imgPaths;
    }

    public void setImgPaths(String imgPaths) {
        this.imgPaths = imgPaths;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getScheduleDay() {
        return scheduleDay;
    }

    public void setScheduleDay(Date scheduleDay) {
        this.scheduleDay = scheduleDay;
    }

    public String getTypeMenu() {
        return typeMenu;
    }

    public void setTypeMenu(String typeMenu) {
        this.typeMenu = typeMenu;
    }

    public String getTimeMenu() {
        return timeMenu;
    }

    public void setTimeMenu(String timeMenu) {
        this.timeMenu = timeMenu;
    }

    public String getMainInfo() {
        return mainInfo;
    }

    public void setMainInfo(String mainInfo) {
        this.mainInfo = mainInfo;
    }

    public String getMinor() {
        return minor;
    }

    public void setMinor(String minor) {
        this.minor = minor;
    }

    public String getCoarseGrain() {
        return coarseGrain;
    }

    public void setCoarseGrain(String coarseGrain) {
        this.coarseGrain = coarseGrain;
    }

    public String getStapleFood() {
        return stapleFood;
    }

    public void setStapleFood(String stapleFood) {
        this.stapleFood = stapleFood;
    }

    public String getDrink() {
        return drink;
    }

    public void setDrink(String drink) {
        this.drink = drink;
    }

    public String getOther() {
        return other;
    }

    public void setOther(String other) {
        this.other = other;
    }

    public String getKcal() {
        return kcal;
    }

    public void setKcal(String kcal) {
        this.kcal = kcal;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
