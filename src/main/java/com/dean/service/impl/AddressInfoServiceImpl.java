package com.dean.service.impl;

import com.dean.dao.AddressInfoDao;
import com.dean.domain.AddressInfo;
import com.dean.service.AddressInfoService;
import com.dean.service.AddressInfoVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by dongxu on 2017/3/1.
 */
@Service
public class AddressInfoServiceImpl implements AddressInfoService {
    @Autowired
    private AddressInfoDao addressInfoDao;
    @Override
    public List<Map<String,Object>> findALl() {
        Iterable<AddressInfo> it = addressInfoDao.findAll();
        Iterator<AddressInfo> iter = it.iterator();
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String,Object> map = null;
        AddressInfo addressInfo = null;
        while(iter.hasNext()){
            addressInfo = iter.next();
            map  =new HashMap<String,Object>();
            map.put("title",addressInfo.getAddress()+addressInfo.getAddressExt());
            map.put("value",addressInfo.getId());
            list.add(map);
        }
        return list;
    }

    @Override
    public List<AddressInfoVO> findAll() {
        Iterable<AddressInfo> its =  addressInfoDao.findAll();
        List<AddressInfoVO> ls = new ArrayList();
        AddressInfoVO addressInfoVO = null;
        AddressInfo addressInfo = null;
        for (Iterator iter = its.iterator(); iter.hasNext();) {
            addressInfo = (AddressInfo)iter.next();
            addressInfoVO = new AddressInfoVO();
            BeanUtils.copyProperties(addressInfo,addressInfoVO);
            ls.add(addressInfoVO);
        }
        return ls;
    }

    @Override
    public AddressInfoVO findById(Long id) {
        AddressInfo addressInfo = addressInfoDao.findOne(id);
        AddressInfoVO addressInfoVO = new AddressInfoVO();
        BeanUtils.copyProperties(addressInfo,addressInfoVO);
        return addressInfoVO;
    }
}
