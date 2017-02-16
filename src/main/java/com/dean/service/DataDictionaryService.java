package com.dean.service;

import com.dean.domain.DataDictionary;

import java.util.List;

/**
 * Created by dongxu on 2017/2/14.
 */
public interface DataDictionaryService {
    public List<DataDictionary> findTypeMenu();

    public List<DataDictionary> findTimeMenu();
}
