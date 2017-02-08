package com.dean.service.impl;

import com.dean.dao.RegeditCodeDao;
import com.dean.domain.RegeditCode;
import com.dean.service.CommonService;
import com.dean.service.SmsService;
import com.dean.util.Constants;
import com.dean.util.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

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
        regeditCode.setScene(Constants.SMS_CODE_SCENE);
        regeditCode.setCode(code);
        regeditCode.setPhone(phone);
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

    @Override
    public boolean regeditCodeVerify(String phone,String code, String openId) {
        boolean boo = false;
        List<RegeditCode> list = regeditCodeDao.findByOpenIdAndSceneOrderByCreateTime(openId,Constants.SMS_CODE_SCENE, DateUtils.getDateByDelay(-1));
        if(list.size()>0){
            RegeditCode regeditCode = list.get(0);
            if(regeditCode.getCode().equals(code)
                    &&regeditCode.getPhone().equals(phone)){
                boo = true;
            }
        }
        return boo;
    }
}
