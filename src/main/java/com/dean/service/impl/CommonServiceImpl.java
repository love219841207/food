package com.dean.service.impl;

import com.dean.dao.RegeditCodeDao;
import com.dean.domain.RegeditCode;
import com.dean.service.CommonService;
import com.dean.service.SmsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * Created by dongxu on 2017/1/27.
 */
@Service
public class CommonServiceImpl implements CommonService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private SmsService smsService;
    @Autowired
    private RegeditCodeDao regeditCodeDao;
    @Override
    public boolean regeditCodeRequest(String phone,String openId) {
        boolean boo = false;
        int random = (int)((Math.random()*9+1)*1000);
        String code = String.valueOf(random);
        RegeditCode regeditCode = new RegeditCode();
        regeditCode.setScene(1);
        regeditCode.setCode(code);
        regeditCode.setOpenId(openId);
        regeditCode.setCreateTime(new Date());
        try{
            regeditCodeDao.save(regeditCode);
            smsService.sendRegdit(phone, code, openId);
            boo = true;
        }catch (Exception e){
            logger.info(e.getMessage());
        }
        return boo;
    }
}
