package com.dean.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by dongxu on 2017/2/4.
 */
public class DateUtils {
    protected static final Logger logger = LoggerFactory.getLogger(DateUtils.class);
    private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
    private static SimpleDateFormat shortD = new SimpleDateFormat("MM月dd日");
    private static String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
    public static Date getDateByDelay(int delay){
        Calendar c = Calendar.getInstance();
        c.add(Calendar.MINUTE,delay);
        return c.getTime();
    }

    public static Date getSpecifiedDayBefore(Date date,int delay) {//可以用new Date().toLocalString()传递参数
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.DAY_OF_YEAR, delay);
        return c.getTime();
    }


    public static String getStringDay(int delay){
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, delay);
        return d.format(cal.getTime());
    }

    public static String getShortStringDate(Date date){
        String str=shortD.format(date);
        return str;
    }

    public static String getStringDate(Date date){
        String str=d.format(date);
        return str;
    }
    public static Date getDate(String str){
        Date date= null;
        try {
            date = d.parse(str);
        } catch (ParseException e) {
            logger.error("时间字符串转化为date错误");
        }
        return date;
    }

    public static String getWeekOfDate(Date dt) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;
        return weekDays[w];
    }


}
