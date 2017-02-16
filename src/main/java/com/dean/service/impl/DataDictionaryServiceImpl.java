package com.dean.service.impl;

import com.dean.dao.DataDictionaryDao;
import com.dean.domain.DataDictionary;
import com.dean.service.DataDictionaryService;
import com.dean.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by dongxu on 2017/2/14.
 */
@Service
public class DataDictionaryServiceImpl implements DataDictionaryService {
    @Autowired
    private DataDictionaryDao dataDictionaryDao;
    @Override
    public List<DataDictionary> findTypeMenu() {
        return dataDictionaryDao.findByCode(Constants.DATA_DIC_TYPE_MENU);
    }

    @Override
    public List<DataDictionary> findTimeMenu() {
        return dataDictionaryDao.findByCode(Constants.DATA_DIC_RIME_MENU);
    }

}
