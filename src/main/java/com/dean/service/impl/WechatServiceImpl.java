package com.dean.service.impl;

import com.dean.config.WechatProperties;
import com.dean.dao.WechatApiTokenDao;
import com.dean.domain.WechatApiToken;
import com.dean.service.*;
import com.dean.util.BaseUtil;
import com.dean.util.Constants;
import com.dean.util.HttpClientUtil;
import com.dean.util.XmlUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;
import java.util.UUID;

/**
 * Created by dongxu on 2017/1/27.
 */
@Service
@EnableConfigurationProperties(WechatProperties.class)
public class WechatServiceImpl implements WechatService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private WechatProperties wechatProperties;
    @Autowired
    private WechatApiTokenDao wechatApiTokenDao;
    //获取openid
    private String URL_GET_OPENID = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code";
    //获取用户信息
    private String ULR_GET_USERINFO_BY_OPENID = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=%s&openid=%s&lang=zh_CN";
   //应用入口
    private String URL_APP_URL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=%s&redirect_uri=%s&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
    //获取api调用access_token
    private String URL_APP_ACCESS_TOKEN="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s";

    private String JSAPITICKET_URL = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=%s&type=jsapi";

    private String paysign_Temp = "appId=%s&nonceStr=%s&package=%s&signType=MD5&timeStamp=%s&key=%s";

    private final String PAY_TYPE = "JSAPI";

    private final String PLACEORDER = "https://api.mch.weixin.qq.com/pay/unifiedorder";

    private String signatureFormat = "jsapi_ticket=%s&noncestr=%s&timestamp=%s&url=%s";

    @Override
    public String getOpenid(String code) {
        String openid = "";
        if(!StringUtils.isEmpty(code)){
            String url = String.format(URL_GET_OPENID, wechatProperties.getAppid(),wechatProperties.getSecret(),code);
            String jsonRet = "";
            try {
                //错误返回{"errcode":40029,"errmsg":"invalid code"}
                //正确返回{"access_token":"ACCESS_TOKEN","expires_in":7200,"refresh_token":"REFRESH_TOKEN","openid":"OPENID","scope":"SCOPE"}
                jsonRet = HttpClientUtil.doGet(url, "UTF-8");
            } catch (Exception e) {
                logger.error("获取openid错误,code为{},错误信息为{}",code,e.getMessage());
            }
            logger.info("http返回openid[{}]", jsonRet);
            JsonNode json = null;
            String token = "";
            try {
                json =  new ObjectMapper().readTree(jsonRet);
            } catch (JsonProcessingException e) {
                logger.error("解析openid信息返回错误{}", code, e.getMessage());
            } catch (IOException e) {
                logger.error("解析openid信息返回错误{}", code, e.getMessage());
            }
            logger.info("http返回json.hasopenid", json.has("openid"));
            logger.info("http返回json.hasopenid", json.path("openid").asText());
            if(json.has("openid")){
                openid = json.path("openid").asText();
            }
            if(json.has("token")){
                token = json.path("token").asText();
            }
            logger.info("解析openid信息成功openid为[{}]", openid);
        }else{
            logger.info("根据code获取openid错误code为空");
        }

        return openid;
    }

    public String getRedirUrl(String appUrl){
        String encodeUrl = URLEncoder.encode(appUrl);
        String url = String.format(URL_APP_URL, wechatProperties.getAppid(),encodeUrl);
        return url;
    }

    @Override
    public boolean refreshApiToken() {
        boolean boo = false;
        String url = String.format(URL_APP_ACCESS_TOKEN, wechatProperties.getAppid(), wechatProperties.getSecret());
        String jsonRet = "";
        try {
            //错误返回{"errcode":40013,"errmsg":"invalid appid"}
            //正确返回{"access_token":"ACCESS_TOKEN","expires_in":7200}
            jsonRet = HttpClientUtil.doGet(url, "UTF-8");
        } catch (Exception e) {
            logger.error("刷新api的token错误,错误信息为[{}]",e.getMessage());
        }
        logger.info("http返回api的token[{}]", jsonRet);
        JsonNode json = null;
        String token = "";
        try {
            json =  new ObjectMapper().readTree(jsonRet);
        } catch (JsonProcessingException e) {
            logger.error("解析api的token信息返回错误{}", e.getMessage());
        } catch (IOException e) {
            logger.error("解析api的token信息返回错误{}", e.getMessage());
        }
        if(json.has("access_token")){
            token = json.path("access_token").asText();
            //默认只有id为1的数据一条
            WechatApiToken wechatApiToken = wechatApiTokenDao.findOne(1l);
            wechatApiToken.setAccessToken(token);
            wechatApiTokenDao.save(wechatApiToken);
            boo = true;
        }
        logger.info("解析api的token成功为[{}]", token);
        return boo;
    }

    public WechatUserInfoVO getWechatHeadImg(String openId){
        WechatUserInfoVO wechatUserInfoVo = new WechatUserInfoVO();
        WechatApiToken wechatApiToken = this.getAccessToken();
        String url = String.format(ULR_GET_USERINFO_BY_OPENID, wechatApiToken.getAccessToken(),openId);

        String jsonRet = "";
        try {
            //错误返回{"errcode":40013,"errmsg":"invalid appid"}
            //正确返回{"subscribe":1,"openid":"o6_bmjrPTlm6_2sgVt7hMZOPfL2M","nickname":"Band","sex":1,"language":"zh_CN","city":"广州","province":"广东","country":"中国","headimgurl":"http://wx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0","subscribe_time":1382694957}
            jsonRet = HttpClientUtil.doGet(url, "UTF-8");
        } catch (Exception e) {
            logger.error("获取wechat头像错误,错误信息为[{}]",e.getMessage());
        }
        logger.info("http获取wechat头像[{}]", jsonRet);
        JsonNode json = null;
        try {
            json =  new ObjectMapper().readTree(jsonRet);
        } catch (JsonProcessingException e) {
            logger.error("解析获取wechat头像信息返回错误{}", e.getMessage());
        } catch (IOException e) {
            logger.error("解析获取wechat头像信息返回错误{}", e.getMessage());
        }
        if(json.has("headimgurl")){
            wechatUserInfoVo.setHeadImg(json.path("headimgurl").asText());
        }
        if(json.has("nickname")){
            wechatUserInfoVo.setNickName(json.path("nickname").asText());
        }
        if(json.has("sex")){
            wechatUserInfoVo.setSex(json.path("sex").asInt());
        }
        if(json.has("subscribe")){
            wechatUserInfoVo.setSubscribe(json.path("subscribe").asInt());
        }
        if(json.has("country")){
            wechatUserInfoVo.setCountry(json.path("country").asText());
        }
        if(json.has("province")){
            wechatUserInfoVo.setProvince(json.path("province").asText());
        }
        if(json.has("city")){
            wechatUserInfoVo.setCity(json.path("city").asText());
        }
        logger.info("解析获取wechat头像信息成功为[{}],nick为[{}]", wechatUserInfoVo.getHeadImg(),wechatUserInfoVo.getNickName());
        return wechatUserInfoVo;
    }

    @Override
    public WxConfig createWxConfig(String url) {
        String timestamp = BaseUtil.create_timestamp();
        String nonce = BaseUtil.create_nonce_str();
        String signature = getSignature(nonce, timestamp, wechatProperties.getPayDomain() + url);
        WxConfig config = new WxConfig();
        config.setAppId(wechatProperties.getAppid());
        config.setNonce(nonce);
        config.setTimestamp(timestamp);
        config.setSignature(signature);
        return config;
    }

    private String getSignature(String noncestr,String timestamp,String url){
        String jsApiTicket = this.getJsApiTicket();
        String signatureUrl = String.format(signatureFormat,jsApiTicket,noncestr,timestamp,url);
        return DigestUtils.shaHex(signatureUrl);
    }

    private WechatApiToken getAccessToken(){
        WechatApiToken wechatApiToken = wechatApiTokenDao.findOne(1l);
        return wechatApiToken;
    }

    private String getJsApiTicket(){
        WechatApiToken wechatApiToken = this.getAccessToken();
        String access_token = wechatApiToken.getAccessToken();
        String jsApiTicket = "";
        if(access_token!=null&&!access_token.equals("")){
            String url = String.format(JSAPITICKET_URL, access_token);
            String response="";
            try {
                response = HttpClientUtil.doGet(url, "UTF-8");
            } catch (Exception e) {
                logger.info(e.getMessage());
            }
            logger.info("response:"+response);
            JsonNode json = null;
            try {
                json =  new ObjectMapper().readTree(response);
            } catch (JsonProcessingException e) {
                logger.info(e.getMessage());
            } catch (IOException e) {
                logger.info(e.getMessage());
            }
            if(json.has("ticket")){
                jsApiTicket = json.path("ticket").asText();
            }
            logger.info("jsApiTicket:"+jsApiTicket);
        }
        return jsApiTicket;
    }

    @Override
    public PayConfig createPayConfig(String openId,String orderId, String attach, String body, String ip, int fee, WxConfig config){
        String prepayId = placeOrder(openId, orderId, attach, body, ip, fee, config.getNonce());
        PayConfig pconfig = new PayConfig();
        pconfig.setPrepayId("prepay_id=" + prepayId);
        String paySign = DigestUtils.md5Hex(String.format(paysign_Temp, wechatProperties.getAppid(), config.getNonce(), pconfig.getPrepayId(), config.getTimestamp(), wechatProperties.getMchkey()));
        pconfig.setPaySign(paySign);
        return pconfig;
    }

    public String placeOrder(String openId,String orderId,String attach,String body,String ip,int fee,String nonce){
        String strTemp = "appid=%s&attach=%s&body=%s&mch_id=%s&nonce_str=%s&notify_url=%s&openid=%s&out_trade_no=%s&spbill_create_ip=%s&total_fee=%s&trade_type=%s&key=%s";
        String signpams = String.format(strTemp,wechatProperties.getAppid(),attach,body,wechatProperties.getMchid()
                ,nonce,wechatProperties.getPayNotify(),openId,orderId,ip,fee,PAY_TYPE,wechatProperties.getMchkey());
        String sign = null;
        try {
            sign = DigestUtils.md5Hex(signpams.getBytes("UTF-8")).toUpperCase();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        StringBuilder str = new StringBuilder();
        str.append("<xml>");
        str.append("<appid><![CDATA[").append(wechatProperties.getAppid()).append("]]></appid>");
        str.append("<attach><![CDATA[").append(attach).append("]]></attach>");
        str.append("<body><![CDATA[").append(body).append("]]></body>");
        str.append("<mch_id><![CDATA[").append(wechatProperties.getMchid()).append("]]></mch_id>");
        str.append("<nonce_str><![CDATA[").append(nonce).append("]]></nonce_str>");
        str.append("<notify_url><![CDATA[").append(wechatProperties.getPayNotify()).append("]]></notify_url>");
        str.append("<openid><![CDATA[").append(openId).append("]]></openid>");
        str.append("<out_trade_no><![CDATA[").append(orderId).append("]]></out_trade_no>");
        str.append("<spbill_create_ip><![CDATA[").append(ip).append("]]></spbill_create_ip>");
        str.append("<total_fee><![CDATA[").append(fee).append("]]></total_fee>");
        str.append("<trade_type><![CDATA[").append(PAY_TYPE).append("]]></trade_type>");
        str.append("<sign><![CDATA[").append(sign).append("]]></sign>");
        str.append("</xml>");
        String res = HttpClientUtil.doPost(PLACEORDER, str.toString(), "UTF-8");
        return this.placeOrder(res);
    }

    private String placeOrder(String res){
        Map<String,String> map = XmlUtil.resolve(res);
        String prepayId = "";
        if(map.containsKey("return_code")
                &&map.containsKey("result_code")
                &&map.get("result_code").equals("SUCCESS")
                &&map.get("return_code").endsWith("SUCCESS")){
            prepayId = map.get("prepay_id");
        }else{
            logger.error("微信统一下单失败{}",res);
        }
        logger.info("微信统一下单prepay_id为[{}]"+prepayId);
        return prepayId;

    }
}
