package com.dean.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by dongxu on 2017/2/4.
 */
public class DateUtils {
    private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public static Date getDateByDelay(int delay){
        Calendar c = Calendar.getInstance();
        c.add(Calendar.MINUTE,delay);
        return c.getTime();
    }
}
