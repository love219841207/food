package com.dean.web;

import com.dean.config.DateEditor;
import com.dean.domain.GroupOrder;
import com.dean.service.*;
import com.dean.util.Constants;
import com.dean.util.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/6/2.
 */
@Controller
@RequestMapping("/group")
public class GroupController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    @InitBinder
    public void initBinder(WebDataBinder binder){
        binder.registerCustomEditor(Date.class, new DateEditor());
        // binder.registerCustomEditor(Double.class, new CustomNumberEditor(Double.class,true));
    }
    @Autowired
    private GroupInfoService groupInfoService;
    @Autowired
    private GroupUserInfoService groupUserInfoService;
    @Autowired
    private GroupOrderService groupOrderService;
    @RequestMapping("/group")
    public String group(ModelMap model,HttpServletRequest request){
        UserVO userVO = (UserVO)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        GroupInfoVO groupInfoVO = groupInfoService.getGroupInfoVOByWechatId(userVO.getWechatInfo().getId());
        model.put("groupInfoVO", groupInfoVO);
        if(groupInfoVO.getStatus()!=null&&groupInfoVO.getStatus()==Constants.BOOK_GROUP_OK){
            return "group/share";
        }else{
            return "group/group";
        }

    }

    @RequestMapping("/save")
    public String save(GroupInfoVO groupInfoVO,Integer av,Integer bv){
        groupInfoService.saveGroupInfo(groupInfoVO);
        return "group/groupsuccess";
    }

    @RequestMapping(value="/reserve/{cid}")
    public String reserve(@PathVariable("cid") Long cid,ModelMap model,HttpServletRequest request){
        logger.info("公司集体订餐cid[{}]", cid);
        UserVO userVO = (UserVO)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        GroupUserInfoVO groupUserInfoVO = groupUserInfoService.getByWechatIdAndCid(userVO.getWechatInfo().getId(), cid);
        model.put("groupUserInfoVO", groupUserInfoVO);
        GroupOrderVO groupOrderVO = groupOrderService.getUserId(groupUserInfoVO.getId());
        model.put("groupOrderVO", groupOrderVO);
        String edit = request.getParameter("edit");
        if(StringUtils.isEmpty(edit)&&groupOrderVO.getId()!=null){
            model.put("canedit", groupOrderService.canEdit());
            model.put("cid", cid);
            return "group/booksuccess";
        }else{
            if(groupOrderVO.getBookDay()!=null){
                model.put("weekDay", "您预订的日期为"+DateUtils.getShortStringDate(groupOrderVO.getBookDay())+"("+DateUtils.getWeekOfDate(groupOrderVO.getBookDay())+")");
            }else{
                model.put("weekDay", "对不起，接下来没有可预订的日期");
            }
            return "group/book";
        }
    }

    @RequestMapping(value="/empsave")
    public String reserve(GroupUserInfoVO groupUserInfoVO,GroupOrderVO groupOrderVO,Long orderId,ModelMap model){
        groupUserInfoVO = groupUserInfoService.saveGroupBook(groupUserInfoVO);
        //由于2个VO对象ID同名，做另外处理
        if(orderId!=null){
            groupOrderVO.setId(orderId);
        }else{
            groupOrderVO.setId(null);
        }
        //员工没有注册情况下塞入userid
        if(groupOrderVO.getGroupUserId()==null){
            groupOrderVO.setGroupUserId(groupUserInfoVO.getId());
        }
        groupOrderService.saveGroupOrderVO(groupOrderVO);
        return "forward:/group/reserve/"+groupUserInfoVO.getCid();
    }

    @RequestMapping("/report")
    public String report(ModelMap model,@RequestParam(value = "chooseDay", required = false) String chooseDay
            ,HttpServletRequest request){
        if(StringUtils.isEmpty(chooseDay)){
            chooseDay = DateUtils.getStringDate(new Date());
        }
        UserVO userVO = (UserVO)request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        GroupInfoVO groupInfoVO = groupInfoService.getGroupInfoVOByWechatId(userVO.getWechatInfo().getId());
        List ls = groupOrderService.findReport(groupInfoVO.getId(),chooseDay);
        model.put("ls", ls);
        model.put("chooseDayVO", new ChooseDayVO(chooseDay));
        return "group/report";
    }

}
