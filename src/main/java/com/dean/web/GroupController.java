package com.dean.web;

import com.dean.service.GroupInfoService;
import com.dean.service.GroupInfoVO;
import com.dean.service.UserVO;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by dongxu on 2017/6/2.
 */
@Controller
@RequestMapping("/group")
public class GroupController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private GroupInfoService groupInfoService;
    @RequestMapping("/group")
    public String group(ModelMap model,HttpServletRequest request){
        UserVO userVO = (UserVO)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        GroupInfoVO groupInfoVO = groupInfoService.getGroupInfoVOByWechatId(userVO.getWechatInfo().getId());
        model.put("groupInfoVO",groupInfoVO);
        return "group/group";
    }

    @RequestMapping("/save")
    public String save(GroupInfoVO groupInfoVO){
        groupInfoService.saveGroupInfo(groupInfoVO);
        return "group/groupsuccess";
    }
}
