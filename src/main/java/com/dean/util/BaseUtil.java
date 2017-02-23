package com.dean.util;

import java.util.UUID;

/**
 * Created by dongxu on 2017/2/23.
 */
public class BaseUtil {
    public static String create_nonce_str() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

    public static String create_timestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }
}
