package com.dean.scheduled;

import com.dean.service.WechatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by dongxu on 2017/2/8.
 * 定时刷新微信的api调用凭证access-token
 */
@Component
public class ScheduledTasks {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @Autowired
    private WechatService wechatService;
    @Scheduled(fixedRate = 1000*60*30)
    public void refreshApiAccessToken() {
        logger.info("定时刷新wechat的api的AccessToken开始时间为[{}]",dateFormat.format(new Date()));
        boolean boo = wechatService.refreshApiToken();
        logger.info("定时刷新wechat的api的AccessTokene,结果为[{}]结束时间为[{}]",boo,dateFormat.format(new Date()));
    }
}
