package com.dean.service;

import java.util.Map;

/**
 * Created by dongxu on 2017/2/10.
 */
public interface GroupInfoService {
    public boolean saveGroupInfo(GroupInfoVO groupInfoVO);

    public GroupInfoVO getGroupInfoVOByWechatId(Long id);

}
