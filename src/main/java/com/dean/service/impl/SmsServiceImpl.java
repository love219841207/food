package com.dean.service.impl;

import com.dean.dao.SmsRecordDao;
import com.dean.domain.SmsRecord;
import com.dean.service.SmsService;
import com.dean.config.SmsProperties;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;


import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by dongxu on 2017/1/27.
 */
@Service
@EnableConfigurationProperties(SmsProperties.class)
public class SmsServiceImpl implements SmsService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    private static final int SMS_SCENE_REGEDIT=1;
    @Autowired
    private SmsProperties smsProperties;
    @Autowired
    private SmsRecordDao smsRecordDao;
    @Override
    public boolean sendRegdit(String phone,String randomCode,String openId) {
        logger.info("[短信发送,短信注册验证START]");
        String paremStr = "";
        Map<String,String> parem= new HashMap<String,String>();
        parem.put("code",randomCode);
        ObjectMapper mapper = new ObjectMapper();
        try {
            paremStr = mapper.writeValueAsString(parem);
        } catch (JsonProcessingException e) {
            logger.info("[短信发送,短信注册验证组装验证码错误{}]", e.getMessage());
        }
        //json.
        boolean boo = this.sendSms(smsProperties.getTemplateCode(),phone,paremStr,openId,SMS_SCENE_REGEDIT);
        logger.info("[短信发送,短信注册验证END,RETURN{}]", boo);
        return boo;
    }

    /**
     *
     * @param templateCode
     * @param phone
     * @param paramStr
     * @param scene    scene[1:短信注册验证]
     * @return
     */
    private boolean sendSms(String templateCode,String phone,String paramStr,String openId,int scene){
        logger.info("[短信发送开始,TEMPLATECODE IS {},PHONE IS {},PARAM IS {}]",templateCode,phone,paramStr);
        AlibabaAliqinFcSmsNumSendResponse rsp = null;
        boolean boo = true;
        SmsRecord smsRecord = new SmsRecord();
        smsRecord.setTemplateCode(templateCode);
        smsRecord.setParamStr(paramStr);
        smsRecord.setScene(scene);
        smsRecord.setPhone(phone);
        try{
            TaobaoClient client =
                    new DefaultTaobaoClient(smsProperties.getUrl()
                            , smsProperties.getAppKey()
                            , smsProperties.getAppSecret());
            AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
            req.setExtend("");
            req.setSmsType(smsProperties.getType());
            req.setSmsFreeSignName(smsProperties.getSignName());
            req.setSmsParamString(paramStr);
            req.setRecNum(phone);
            req.setSmsTemplateCode(smsProperties.getTemplateCode());
            rsp = client.execute(req);
            logger.info("[短信发送结束,成功，返回信息为:{}]", rsp.getBody());
        } catch (ApiException e) {
            boo = false;
            logger.info("[短信发送结束,失败,返回信息为:{},错误信息为{}]", rsp.getBody(),e.getErrMsg());
        }

        if(!StringUtils.isEmpty(rsp.getErrorCode())){
            smsRecord.setState(rsp.getErrorCode());
        }
        if(!StringUtils.isEmpty(rsp.getSubMsg())){
            smsRecord.setErrorMsg(rsp.getSubMsg());
        }
        if(!StringUtils.isEmpty(rsp.getBody())){
            smsRecord.setSmsBody(rsp.getBody());
        }
        this.saveSmsRecord(smsRecord);
        return boo;
    }

    private void saveSmsRecord(SmsRecord smsRecord){
        smsRecord.setSendTime(new Date());
        smsRecordDao.save(smsRecord);
    }
}
