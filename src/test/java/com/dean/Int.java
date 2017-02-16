package com.dean;

import javax.persistence.Convert;

/**
 * Created by dongxu on 2017/2/15.
 */
public class Int {
    public static void main(String[] arg0){
        String s = "1.1";
        double d = Double.valueOf(s);
        System.out.println((int)d);
    }
}
