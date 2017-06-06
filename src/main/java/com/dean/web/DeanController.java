package com.dean.web;

import com.dean.service.MenuService;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by dongxu on 2017/5/16.
 */
@Controller
@RequestMapping("/dean")
public class DeanController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @Autowired
    private MenuService menuService;
    @ResponseBody
    @RequestMapping("/menu")
    public String menu(){
        logger.info("手动刷新batchMenu开始时间为[{}]",dateFormat.format(new Date()));
        try {
            menuService.initMenuFromExcel();
        } catch (IOException e) {
            logger.error("手动刷新batchMenu错误[{}]",e.getMessage());
        } catch (InvalidFormatException e) {
            logger.error("手动刷新batchMenu错误[{}]", e.getMessage());
        }
        logger.info("手动刷新batchMenu结束,结束时间为[{}]",dateFormat.format(new Date()));
        return "OK";
    }
}
