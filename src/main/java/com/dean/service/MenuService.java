package com.dean.service;

import com.dean.util.Constants;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;

import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/2/14.
 */
public interface MenuService {
    List<TypeMenuVO> findTypeMenu();

    List<TimeMenuVO> findTimeMenu();

    void initMenuFromExcel() throws IOException, InvalidFormatException;

    List<MenuInfoVO> findMenuDetail(String day, String typeMenu);

    List<Date> findFixDate(int nextOffset);

}
