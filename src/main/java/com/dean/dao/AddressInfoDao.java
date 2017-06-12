package com.dean.dao;

import com.dean.domain.AddressInfo;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by dongxu on 2017/2/23.
 */
public interface AddressInfoDao extends CrudRepository<AddressInfo,Long>{
}
