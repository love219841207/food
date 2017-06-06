package com.dean.service.impl;

import com.dean.dao.GroupOrderDao;
import com.dean.dao.GroupUserInfoDao;
import com.dean.dao.ScheduleMenuInfoDao;
import com.dean.domain.GroupOrder;
import com.dean.domain.GroupUserInfo;
import com.dean.service.GroupUserInfoService;
import com.dean.service.GroupUserInfoVO;
import com.dean.service.MenuService;
import com.dean.util.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Date;


/**
 * Created by dongxu on 2017/6/6.
 */
@Service
public class GroupUserInfoServiceImpl implements GroupUserInfoService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private GroupUserInfoDao groupUserInfoDao;
    @Autowired
    private GroupOrderDao groupOrderDao;
    @Override
    public GroupUserInfoVO getByWechatIdAndCid(Long wechatId, Long cid) {
        GroupUserInfo groupUserInfo = groupUserInfoDao.getByWechatIdAndCid(wechatId, cid);
        GroupUserInfoVO groupUserInfoVO = new GroupUserInfoVO();
        if(groupUserInfo!=null){
            BeanUtils.copyProperties(groupUserInfo, groupUserInfoVO);
        }else{
            groupUserInfoVO.setWechatId(wechatId);
            groupUserInfoVO.setCid(cid);
        }
        return groupUserInfoVO;
    }

    @Override
    @Transactional
    public GroupUserInfoVO saveGroupBook(GroupUserInfoVO groupUserInfoVO) {
        logger.info("团体订餐员工提交姓名、部门");
        GroupUserInfo groupUserInfo = null;
        if(groupUserInfoVO.getId()==null){
            groupUserInfo = new GroupUserInfo();
            BeanUtils.copyProperties(groupUserInfoVO,groupUserInfo);
            groupUserInfo.setCreateTime(new Date());
        }else{
            groupUserInfo = groupUserInfoDao.findOne(groupUserInfoVO.getId());
            groupUserInfo.setName(groupUserInfoVO.getName());
            groupUserInfo.setDep(groupUserInfoVO.getDep());
        }
        try{
            groupUserInfoDao.save(groupUserInfo);
        }catch (Exception e){
            logger.error("保存失败[{}]",e.getMessage());
        }
        logger.info("团体订餐员工提交姓名、部门保存成功");
       // GroupOrder order = groupOrderDao
        BeanUtils.copyProperties(groupUserInfo,groupUserInfoVO);
        return groupUserInfoVO;
    }
}
