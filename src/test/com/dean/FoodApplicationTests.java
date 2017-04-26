package com.dean;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.IOException;
import java.text.SimpleDateFormat;

@RunWith(SpringRunner.class)
@SpringBootTest
public class FoodApplicationTests {
	protected static final Logger logger = LoggerFactory.getLogger(com.dean.POITest.class);
	private static SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");

	/*@Autowired
	private SmsRecordDao smsRecordDao;*/


	@Test
	public void contextLoads() throws IOException, InvalidFormatException {

	/*	System.out.print(smsRecordDao.findOneByOpenId("oR6mewQ8GPvyXqGd0J3mUg7U7CYk").getPhone());*/
	}

}
