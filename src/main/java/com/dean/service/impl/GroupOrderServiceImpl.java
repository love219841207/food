package com.dean.service.impl;

import com.dean.dao.GroupOrderDao;
import com.dean.domain.GroupOrder;
import com.dean.service.GroupOrderService;
import com.dean.service.GroupOrderVO;
import com.dean.service.MenuService;
import com.dean.util.Constants;
import com.dean.util.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/6/6.
 */
@Service
public class GroupOrderServiceImpl implements GroupOrderService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private MenuService menuService;
    @Autowired
    private GroupOrderDao groupOrderDao;
    @Override
    public GroupOrderVO getUserId(Long groupUserId) {
        Date nextDay = this.nextScheduleDay();
        GroupOrder groupOrder = null;
        if(nextDay==null||groupUserId==null){
            logger.info("下面没有排餐计划");
        }else{
            groupOrder = groupOrderDao.findByGroupUserIdAndBookDay(groupUserId,nextDay);
        }
        GroupOrderVO groupOrderVO = new GroupOrderVO();
        if(groupOrder!=null){
            logger.info("提取出了团体订餐计划");
            BeanUtils.copyProperties(groupOrder,groupOrderVO);
        }else{
            if(nextDay!=null){
                groupOrderVO.setBookDay(nextDay);
            }
        }
        return groupOrderVO;
    }

    @Override
    public void saveGroupOrderVO(GroupOrderVO groupOrderVO) {
        GroupOrder groupOrder = null;
        if(groupOrderVO.getId()==null){
            groupOrder = new GroupOrder();
            BeanUtils.copyProperties(groupOrderVO,groupOrder);
            groupOrder.setCreateTime(new Date());
            groupOrder.setUpdateTime(new Date());
        }else{
            groupOrder = groupOrderDao.findOne(groupOrderVO.getId());
            groupOrder.setAv(groupOrderVO.getAv());
            groupOrder.setBv(groupOrderVO.getBv());
            groupOrder.setUpdateTime(new Date());
        }
        try{
            groupOrderDao.save(groupOrder);
        }catch (Exception e){
            logger.error("团体订单提交失败了[{}]",e.getMessage());
        }

    }

    @Override
    public boolean canEdit() {
        boolean boo = false;
        Date d = new Date();
        int hours = d.getHours();
        if(hours< Constants.GROUP_OEDER_EDIT_LAST_HOUR){
            boo = true;
        }
        return boo;
    }

    private Date nextScheduleDay(){
        //获取下一个排餐日期
        List<Date> ls =  menuService.findFixDate(1);
        if(ls.size()>0){
            logger.info("获取下一个排餐日期[{}]", DateUtils.getStringDate(ls.get(0)));
            return ls.get(0);
        }else{
            logger.info("获取下一个排餐日期[空]");
            return null;
        }
    }
}
