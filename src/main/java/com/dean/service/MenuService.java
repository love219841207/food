package com.dean.service;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;

import java.io.IOException;
import java.util.List;

/**
 * Created by dongxu on 2017/2/14.
 */
public interface MenuService {
    public List<TypeMenuVO> findTypeMenu();

    public List<TimeMenuVO> findTimeMenu();

    public void initMenuFromExcel() throws IOException, InvalidFormatException;

    public List<MenuInfoVO> findMenuDetail(String day,String typeMenu);
}
