package com.dean.service.impl;

import com.dean.dao.AddressInfoDao;
import com.dean.dao.UserDeliveryAddressDao;
import com.dean.domain.AddressInfo;
import com.dean.domain.UserDeliveryAddress;
import com.dean.service.DeliveryAddressService;
import com.dean.service.DeliveryAddressVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by dongxu on 2017/3/1.
 */
@Service
public class DeliveryAddressServiceImpl implements DeliveryAddressService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private UserDeliveryAddressDao userDeliveryAddressDao;

    @Override
    public List<DeliveryAddressVO> findByUserId(Long userId) {
        List<UserDeliveryAddress> list = userDeliveryAddressDao.findByUserId(userId);
        List<DeliveryAddressVO> retlist = new ArrayList<DeliveryAddressVO>();
        DeliveryAddressVO deliveryAddressVO = null;
        for (UserDeliveryAddress uda : list){
            deliveryAddressVO = new DeliveryAddressVO();
            BeanUtils.copyProperties(uda, deliveryAddressVO);
            deliveryAddressVO.setAddressName(uda.getAddress().getAddress());
            deliveryAddressVO.setAddressId(uda.getAddress().getId());
            retlist.add(deliveryAddressVO);
        }
        return retlist;
    }

    @Override
    public DeliveryAddressVO findById(Long id) {
        DeliveryAddressVO deliveryAddressVO = new DeliveryAddressVO();
        UserDeliveryAddress deliveryAddress = userDeliveryAddressDao.findOne(id);
        BeanUtils.copyProperties(deliveryAddress, deliveryAddressVO);
        deliveryAddressVO.setAddressName(deliveryAddress.getAddress().getAddress());
        deliveryAddressVO.setAddressId(deliveryAddress.getAddress().getId());
        return deliveryAddressVO;
    }

    @Override
    public void save(DeliveryAddressVO deliveryAddressVO){
        UserDeliveryAddress deliveryAddress = null;
        if(deliveryAddressVO.getId()!=null){
            deliveryAddress = userDeliveryAddressDao.findOne(deliveryAddressVO.getId());
        }else{
            deliveryAddress = new UserDeliveryAddress();
            deliveryAddress.setUserId(deliveryAddressVO.getUserId());
        }
        deliveryAddress.setName(deliveryAddressVO.getName());
        deliveryAddress.setPhone(deliveryAddressVO.getPhone());
        deliveryAddress.setAddressExtend(deliveryAddressVO.getAddressExtend());
        AddressInfo addressInfo = new AddressInfo();
        addressInfo.setId(deliveryAddressVO.getAddressId());
        deliveryAddress.setAddress(addressInfo);
        userDeliveryAddressDao.save(deliveryAddress);
    }

    @Override
    public void delete(Long id) {

    }
}
