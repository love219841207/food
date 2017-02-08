package com.dean.web.wechat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by dongxu on 2017/2/1.
 */
@Controller
@RequestMapping("/wechat")
public class WechatController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @RequestMapping("/core")
    public void core(HttpServletRequest request,HttpServletResponse response){
        String echostr = request.getParameter("echostr");
        logger.info("echostr is {}",echostr);
        //dfc31eac75a12afcae2a43d8c11c94c1
        PrintWriter out = null;
        try {
            out = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }

        out.print(echostr);
    }
}
