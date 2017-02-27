package com.dean.web.wechat;

import com.dean.service.WechatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

/**
 * Created by dongxu on 2017/2/1.
 */
@Controller
@RequestMapping("/wechat")
public class WechatController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private WechatService wechatService;
    @RequestMapping("/core")
    public void core(HttpServletRequest request,HttpServletResponse response){
        String echostr = request.getParameter("echostr");
        logger.info("echostr is {}",echostr);
        PrintWriter out = null;
        try {
            out = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }

        out.print(echostr);
    }

   /* @RequestMapping("/notify")
    @ResponseBody
    public String notify(){
        return "";
    }*/
   @RequestMapping("/notify")
   @ResponseBody
    public String nofify(HttpServletRequest request) throws IOException {
       String payback = this.convertStreamToString(request.getInputStream());
       logger.info("wechat pay notify [{}]",payback);
       wechatService.orderCallBack(payback);
       return "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
    }

    private String convertStreamToString(InputStream is){
 /*
          * To convert the InputStream to String we use the BufferedReader.readLine()
          * method. We iterate until the BufferedReader return null which means
          * there's no more data to read. Each line will appended to a StringBuilder
          * and returned as String.
          */
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();

        String line = null;
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line + "\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return sb.toString();
    }

}
