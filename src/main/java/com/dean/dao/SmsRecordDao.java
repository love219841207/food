package com.dean.dao;

import com.dean.domain.SmsRecord;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by dongxu on 2017/1/27.
 */
public interface SmsRecordDao extends CrudRepository<SmsRecord,Long>{
}
