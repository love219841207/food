package com.dean.web;

import com.dean.service.CommonService;
import com.dean.service.UserVO;
import com.dean.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by dongxu on 2017/1/27.
 */
@Controller
@RequestMapping("/common")
public class CommonController {
    @Autowired
    private CommonService commonService;
    @RequestMapping("/regeditCode/{phone}")
    @ResponseBody
    public boolean regeditCode(HttpServletRequest request,
                              @PathVariable String phone){
        UserVO userVO = (UserVO)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        boolean boo = commonService.regeditCodeRequest(phone,userVO.getWechatInfo().getOpenId());
        return boo;
    }

    @RequestMapping("/verify/{phone}/{code}")
    @ResponseBody
    public boolean verify(HttpServletRequest request,
                          @PathVariable String phone,
                          @PathVariable String code){
        UserVO userVO = (UserVO)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        boolean boo = commonService.regeditCodeVerify(phone,code,userVO.getWechatInfo().getOpenId());
        return boo;
    }
}
