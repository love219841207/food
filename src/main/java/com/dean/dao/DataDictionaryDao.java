package com.dean.dao;

import com.dean.domain.DataDictionary;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by dongxu on 2017/2/14.
 */
public interface DataDictionaryDao extends CrudRepository<DataDictionary,Integer>{
    public List<DataDictionary> findByCode(String code);
}
