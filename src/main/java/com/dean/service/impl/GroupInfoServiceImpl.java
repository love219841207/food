package com.dean.service.impl;

import com.dean.dao.GroupInfoDao;
import com.dean.domain.GroupInfo;
import com.dean.service.GroupInfoService;
import com.dean.service.GroupInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;

/**
 * Created by dongxu on 2017/2/10.
 */
@Service
public class GroupInfoServiceImpl implements GroupInfoService {
    @Autowired
    private GroupInfoDao groupInfoDao;
    @Override
    public boolean saveGroupInfo(GroupInfoVO groupInfoVO) {
        boolean boo = false;
        GroupInfo groupInfo = new GroupInfo();
        if(groupInfoVO!=null){
            groupInfo.setCreateTime(new Date());
            groupInfo.setGroupName(groupInfoVO.getGroupName());
            groupInfo.setName(groupInfoVO.getName());
            groupInfo.setRemark(groupInfoVO.getRemark());
            if (!StringUtils.isEmpty(groupInfoVO.getPhone())){
                if(groupInfoVO.getPhone().length()>11){
                    groupInfo.setPhone(groupInfoVO.getPhone().substring(groupInfoVO.getPhone().length()-11));
                }else{
                    groupInfo.setPhone(groupInfoVO.getPhone());
                }
            }
            groupInfoDao.save(groupInfo);
            boo = true;
        }
        return boo;
    }
}
