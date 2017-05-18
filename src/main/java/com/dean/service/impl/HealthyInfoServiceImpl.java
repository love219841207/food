package com.dean.service.impl;

import com.dean.dao.HealthyInfoDao;
import com.dean.domain.HealthyInfo;
import com.dean.service.BodyIndexVO;
import com.dean.service.HealthyInfoService;
import com.dean.service.HealthyInfoVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by dongxu on 2017/5/10.
 */
import org.springframework.stereotype.Service;
@Service
public class HealthyInfoServiceImpl implements HealthyInfoService {
    private static DecimalFormat df   =new DecimalFormat("#.00");
    @Autowired
    private HealthyInfoDao healthyInfoDao;
    @Override
    public HealthyInfoVO getHealthyInfoVO(Long userId) {
        HealthyInfo healthyInfo = healthyInfoDao.findByUserId(userId);
        HealthyInfoVO healthyInfoVO = new HealthyInfoVO();
        if(healthyInfo!=null){
            BeanUtils.copyProperties(healthyInfo, healthyInfoVO);
        }else{
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.YEAR,-10);
            healthyInfoVO.setBirthday(cal.getTime());
            healthyInfoVO.setUserId(userId);
            healthyInfoVO.setSex(0);
            healthyInfoVO.setActivity(0);
            healthyInfoVO.setTarget(0);
        }
        return healthyInfoVO;
    }

    @Override
    public void save(HealthyInfoVO healthyInfoVO) {
        HealthyInfo healthyInfo = new HealthyInfo();
        BeanUtils.copyProperties(healthyInfoVO, healthyInfo);
        if(healthyInfo.getHeight()==null||healthyInfo.getHeight()<0){
            healthyInfo.setHeight(0d);
        }else{
            healthyInfo.setHeight(convert(healthyInfo.getHeight()));
        }
        if(healthyInfo.getWeight()==null||healthyInfo.getWeight()<0){
            healthyInfo.setWeight(0d);
        }else{
            healthyInfo.setWeight(convert(healthyInfo.getWeight()));
        }
        healthyInfo.setLast_update_time(new Date());
        healthyInfoDao.save(healthyInfo);
    }

    @Override
    public BodyIndexVO getBodyIndexVO(Long userId) {
        HealthyInfo healthyInfo = healthyInfoDao.findByUserId(userId);
        BodyIndexVO bodyIndexVO = new BodyIndexVO();
        bodyIndexVO.setUserId(userId);
        if(healthyInfo!=null){
            if(healthyInfo.getHeight()>0&&healthyInfo.getWeight()>0){
                bodyIndexVO.setBmi(this.getBmi(healthyInfo.getHeight(),healthyInfo.getWeight()));
                bodyIndexVO.setBmiLevel(this.getBmiStr(bodyIndexVO.getBmi()));
                bodyIndexVO.setMetabolize(this.getMetabolize(healthyInfo.getSex(), healthyInfo.getWeight()
                        , healthyInfo.getHeight(), healthyInfo.getBirthday()));
                bodyIndexVO.setConsume(this.getConsume(bodyIndexVO.getMetabolize(), healthyInfo.getActivity()));
                bodyIndexVO.setCaloricReq(this.getCaloricReq(bodyIndexVO.getMetabolize(),bodyIndexVO.getConsume()));
            }
        }
        return bodyIndexVO;
    }

    private Double getCaloricReq(Double metabolize,Double consume){
        Double caloricReq = (metabolize+consume)*1.1;
       return  convert(caloricReq);
    }

    private Double getConsume(Double metabolize,Integer activity){
        Double consume = 0d;
        Double rate = 0d;
        switch(activity){
            case 0 :
                rate = 0.05;
                break;
            case 1 :
                rate = 0.199;
                break;
            case 2 :
                rate = 0.374;
                break;
            case 3 :
                rate = 0.549;
                break;
            case 4 :
                rate = 0.726;
                break;
            case 5 :
                rate = 0.899;
                break;
        }
        consume = metabolize*rate;
        return convert(consume);
    }

    private double convert(double d){
        BigDecimal b =new BigDecimal(d);
        return b.setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    private Double getMetabolize(int sex,Double weight,Double height,Date birthDay){
        int age = 0;
        try {
            age = this.getAge(birthDay);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Double metabolize = 0d;
        if(sex==0){
            metabolize = 13.7*weight + (5*height) - 6.8*age+66;
        }else{
            metabolize = 9.6*weight + (1.8*height) - 4.7*age+655;
        }
        return  convert(metabolize);
    }

    private Double getBmi(Double height,Double weight){
        Double bmi = weight/(Math.pow(height/100,2));
        BigDecimal b = new BigDecimal(bmi);
        return b.setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    private String getBmiStr(Double bmi){
        String str = "";
        if(bmi<18.5){
           str = "体重过轻";
        }else if(bmi<24.0){
            str = "体重正常";
        }else if(bmi<28.0){
            str = "超重";
        }else{
            str = "肥胖";
        }
        return str;
    }

    private int getAge(Date birthDay) throws Exception {
        Calendar cal = Calendar.getInstance();
        if (cal.before(birthDay)) {
            throw new IllegalArgumentException(
                    "The birthDay is before Now.It's unbelievable!");
        }
        int yearNow = cal.get(Calendar.YEAR);
        int monthNow = cal.get(Calendar.MONTH)+1;
        int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH);
        cal.setTime(birthDay);
        int yearBirth = cal.get(Calendar.YEAR);
        int monthBirth = cal.get(Calendar.MONTH);
        int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);
        int age = yearNow - yearBirth;
        if (monthNow <= monthBirth) {
            if (monthNow == monthBirth) {
                //monthNow==monthBirth
                if (dayOfMonthNow < dayOfMonthBirth) {
                    age--;
                }
            } else {
                //monthNow>monthBirth
                age--;
            }
        }
        return age;
    }
}
