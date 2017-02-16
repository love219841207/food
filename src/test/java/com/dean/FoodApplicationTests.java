package com.dean;

import com.dean.service.MenuService;
import com.dean.service.UserService;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;

@RunWith(SpringRunner.class)
@SpringBootTest
public class FoodApplicationTests {
	protected static final Logger logger = LoggerFactory.getLogger(POITest.class);
	private static SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");

	@Autowired
	private MenuService menuService;


	@Test
	public void contextLoads() throws IOException, InvalidFormatException {
		menuService.initMenuFromExcel();
	}

}
