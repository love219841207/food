package com.dean.util;

import java.text.SimpleDateFormat;

/**
 * Created by dongxu on 2017/2/4.
 */
public class Constants {
    //手机验证码注册绑定
    public static final int SMS_CODE_SCENE=1;

    //session的key
    public static final String SESSION_USER_KEY = "userVO";


    public static final String DATA_DIC_TYPE_MENU = "type_menu";

    public static final String DATA_DIC_TIME_MENU = "time_menu";

    public static final SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");


    //订单预生成
    public static final int ORDER_STATUS_PREPARE = 0;

    //确认后申请微信支付，使用优惠券等，确认最后支付金额
    public static final int ORDER_STATUS_CHECK = 1;
    //订单页面支付成功，未到账
    public static final int ORDER_STATUS_PAYED = 2;

    //订单支付到账
    public static final int ORDER_STATUS_PAYED_ARRIVAL = 3;

    //订单支付失败
    public static final int ORDER_STATUS_FAIL = 4;

    //订单异常
    public static final int ORDER_STATUS_ERROR = 8;

    //订单作废
    public static final int ORDER_STATUS_WASTE = 9;

    //优惠券可用
    public static final int COUPON_STATUS_VALID = 1;

    //优惠券使用
    public static final int COUPON_STATUS_USED = 2;

}
