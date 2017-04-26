package com.dean;

import com.dean.domain.OrderInfo;
import com.dean.service.OrderInfoVO;
import org.springframework.beans.BeanUtils;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by dongxu on 2017/2/21.
 */
public class CopyTest {
    public static void main(String[] agrg0){
        OrderInfo orderInfo = new OrderInfo();
        orderInfo.setTypeMenu("1");
        orderInfo.setCreateTime(new Date());
        OrderInfoVO orderInfoVO = new OrderInfoVO();
        BeanUtils.copyProperties(orderInfo, orderInfoVO);
        System.out.print(orderInfoVO.getTypeMenu());
        System.out.println(orderInfoVO.getCreateTime());
        BigDecimal a  = new BigDecimal(0);
        BigDecimal aa  = new BigDecimal(1);
        a = a.add(aa);
        System.out.println(a);

    }
}
