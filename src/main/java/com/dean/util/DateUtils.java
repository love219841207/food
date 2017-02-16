package com.dean.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by dongxu on 2017/2/4.
 */
public class DateUtils {
    private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static SimpleDateFormat d = new SimpleDateFormat("yyyy-MM-dd");
    public static Date getDateByDelay(int delay){
        Calendar c = Calendar.getInstance();
        c.add(Calendar.MINUTE,delay);
        return c.getTime();
    }


    public static String getStringDay(int delay){
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, delay);
        return d.format(cal.getTime());
    }

}
