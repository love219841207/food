package com.dean.service;

import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by dongxu on 2017/2/16.
 */
public class MenuInfoVO {
    private Long id;
    private String scheduleDay;
    private String typeMenu;
    private String timeMenu;
    private String timeMenuVal;
    private String mainInfo;
    private String minor;
    private String coarseGrain;
    private String stapleFood;
    private String drink;
    private String other;
    private String kcal;
    private List<String> imgs;
    private List<String> mainImgs;
    private List<PkgMenuVO> pkgMenuVOs;

    public List<String> getMainImgs() {
        return mainImgs;
    }

    public void setMainImgs(String mainImgPath) {
        if(!StringUtils.isEmpty(mainImgPath)){
            String[] arr = mainImgPath.split(",");
            this.mainImgs = Arrays.asList(arr);
        }else{
            this.mainImgs = new ArrayList<String>();
        }
    }

    public List<PkgMenuVO> getPkgMenuVOs() {
        return pkgMenuVOs;
    }

    public void setPkgMenuVOs(List<PkgMenuVO> pkgMenuVOs) {
        this.pkgMenuVOs = pkgMenuVOs;
    }

    public List<String> getImgs() {
        return imgs;
    }

    public void setImgs(String imgPaths) {
        if(!StringUtils.isEmpty(imgPaths)){
            String[] arr = imgPaths.split(",");
            this.imgs = Arrays.asList(arr);
        }else{
            this.imgs = new ArrayList<String>();
        }
    }

    public String getTimeMenuVal() {
        return timeMenuVal;
    }

    public void setTimeMenuVal(String timeMenuVal) {
        this.timeMenuVal = timeMenuVal;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getScheduleDay() {
        return scheduleDay;
    }

    public void setScheduleDay(String scheduleDay) {
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
}
