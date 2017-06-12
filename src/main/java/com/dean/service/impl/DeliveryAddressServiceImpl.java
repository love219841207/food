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
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
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
    @Autowired
    private AddressInfoDao addressInfoDao;

    @Override
    public List<DeliveryAddressVO> findByUserId(Long userId) {
        List<UserDeliveryAddress> list = userDeliveryAddressDao.findByUserId(userId);
        List<DeliveryAddressVO> retlist = new ArrayList<DeliveryAddressVO>();
        DeliveryAddressVO deliveryAddressVO = null;
        for (UserDeliveryAddress uda : list){
            deliveryAddressVO = new DeliveryAddressVO();
            BeanUtils.copyProperties(uda, deliveryAddressVO);
            deliveryAddressVO.setAddressName(uda.getAddress().getAddressExt()+ " <br> (" +uda.getAddress().getAddress() +" )");
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
    @Transactional
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
        if( StringUtils.isEmpty(deliveryAddress.getDft())
                &&!StringUtils.isEmpty(deliveryAddressVO.getDft())){
            deliveryAddress.setDft(deliveryAddressVO.getDft());
            if(deliveryAddress.getId()!=null){
                userDeliveryAddressDao.batchUpdateExId(deliveryAddress.getUserId(),deliveryAddress.getId());
            }else{
                userDeliveryAddressDao.batchUpdate(deliveryAddress.getUserId());
            }
        }
        deliveryAddress.setAddressExtend(deliveryAddressVO.getAddressExtend());
        AddressInfo addressInfo = addressInfoDao.findOne(deliveryAddressVO.getAddressId());
        deliveryAddress.setAddress(addressInfo);
        userDeliveryAddressDao.save(deliveryAddress);
    }

    @Override
    public void delete(Long id) {
        userDeliveryAddressDao.delete(id);
    }

    @Override
    public DeliveryAddressVO getPlanDeliveryAddressVO(Long id,Long userId) {
        UserDeliveryAddress deliveryAddress = null;
        DeliveryAddressVO deliveryAddressVO = null;
        List<UserDeliveryAddress> list = null;
        if(id!=null){
            list = userDeliveryAddressDao.findByUserIdAndId(userId,id);
        }else{
            list= userDeliveryAddressDao.findDefault(userId);
        }
        if(list.size()>0){
            deliveryAddress = list.get(0);
            deliveryAddressVO = new DeliveryAddressVO();
            BeanUtils.copyProperties(deliveryAddress, deliveryAddressVO);
            deliveryAddressVO.setAddressName(deliveryAddress.getAddress().getAddress());
            deliveryAddressVO.setAddressId(deliveryAddress.getAddress().getId());
        }
        return deliveryAddressVO;
    }
}
