package com.dean.web;
import com.dean.service.GroupInfoService;
import com.dean.service.GroupInfoVO;
import com.dean.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



/**
 * Created by dongxu on 2017/2/9.
 */

@Controller
@RequestMapping("/book")
public class BookController {
  //  com.fasterxml.jackson.databind.ObjectWriter
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private UserService userService;
    @Autowired
    private GroupInfoService groupInfoService;
    @RequestMapping("/group")
    public String group(){
       return "book/group";
    }

    @RequestMapping("/groupsub")
    public String groupsub(GroupInfoVO groupInfoVO){
        groupInfoService.saveGroupInfo(groupInfoVO);
        return "book/groupsuccess";
    }

    @RequestMapping("/single")
    public String single() {
        return "book/single";
    }
}
