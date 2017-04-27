package com.dean.web;

import com.dean.service.AddressInfoService;
import com.dean.service.DeliveryAddressService;
import com.dean.service.DeliveryAddressVO;
import com.dean.service.UserVO;
import com.dean.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by dongxu on 2017/3/1.
 */
@Controller
@RequestMapping("/delivery")
public class DeliveryAddressController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private DeliveryAddressService deliveryAddressService;
    @Autowired
    private AddressInfoService addressInfoService;
    @RequestMapping("/edit")
    public String edit(@RequestParam(value = "id",required = false) Long id
                       ,HttpServletRequest request
            ,ModelMap model){
        logger.info("个人地址编辑id为[{}]", id);
        UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        logger.info("userVO[{}]", userVO==null);
        logger.info("userVO[{}]", userVO.getUserInfo()==null);
        logger.info("userVO[{}]" ,userVO.getUserInfo().getId());
        DeliveryAddressVO deliveryAddressVO = null;
        if(id!=null){
            deliveryAddressVO = deliveryAddressService.findById(id);
        }else{
            deliveryAddressVO = new DeliveryAddressVO();
            deliveryAddressVO.setUserId(userVO.getUserInfo().getId());
        }
        model.put("deliveryAddressVO", deliveryAddressVO);
        return "delivery/edit";
    }

    @RequestMapping("/del")
    public String del(@RequestParam(value = "id",required = false) Long id){
        if(id!=null){
            deliveryAddressService.delete(id);
        }
        return "forward:/delivery/list";
    }


    @RequestMapping("/listAddress")
    @ResponseBody
    public List<Map<String,Object>> edit(){
        List<Map<String,Object>> list = addressInfoService.findALl();
        return list;
    }


    @RequestMapping("/save")
    public String save(DeliveryAddressVO deliveryAddressVO){
        deliveryAddressService.save(deliveryAddressVO);
        return "forward:/delivery/list";
    }

    @RequestMapping("/list")
    public String list(ModelMap model ,HttpServletRequest request,@RequestParam(value = "choose",required = false) String choose){
        UserVO userVO = (UserVO) request.getSession().getAttribute(Constants.SESSION_USER_KEY);
        logger.info("userVO[{}]", userVO==null);
        logger.info("userVO[{}]", userVO.getUserInfo()==null);
        logger.info("userVO[{}]" ,userVO.getUserInfo().getId());

        List<DeliveryAddressVO> list =  deliveryAddressService.findByUserId(userVO.getUserInfo().getId());
        model.put("list", list);
        model.put("isChoose", !StringUtils.isEmpty(choose));
        return "delivery/list";
    }

}
