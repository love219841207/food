package com.dean.service.impl;

import com.dean.dao.WechatApiTokenDao;
import com.dean.domain.WechatApiToken;
import com.dean.service.WechatService;
import com.dean.config.WechatProperties;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.dean.util.HttpClientUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.net.URLEncoder;

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
        String url = String.format(URL_APP_ACCESS_TOKEN, wechatProperties.getAppid(),wechatProperties.getSecret());
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

    public String getWechatHeadImg(String openId){
        WechatApiToken wechatApiToken = wechatApiTokenDao.findOne(1l);
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
        String headimgurl = "";
        try {
            json =  new ObjectMapper().readTree(jsonRet);
        } catch (JsonProcessingException e) {
            logger.error("解析获取wechat头像信息返回错误{}", e.getMessage());
        } catch (IOException e) {
            logger.error("解析获取wechat头像信息返回错误{}", e.getMessage());
        }
        if(json.has("headimgurl")){
            headimgurl = json.path("headimgurl").asText();
        }
        logger.info("解析获取wechat头像信息成功为[{}]", headimgurl);
        return headimgurl;
    }
}
