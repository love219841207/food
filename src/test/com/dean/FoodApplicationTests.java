package com.dean;

import com.dean.service.MenuService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class FoodApplicationTests {
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());


/*	@Autowired
	private MenuService menuService;*/


	@Test
	public void a() {
		/*//logger.info("menuService==null[{}]",menuService==null);
		System.out.print("menuService");
		//menuService.initMenuFromExcel();*/
	/*	System.out.print(smsRecordDao.findOneByOpenId("oR6mewQ8GPvyXqGd0J3mUg7U7CYk").getPhone());*/
	}

	@Test
	public void b() {

		System.out.print("menuService");

	}

}
