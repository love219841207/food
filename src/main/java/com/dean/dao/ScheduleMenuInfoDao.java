package com.dean.dao;

import com.dean.domain.ScheduleMenuInfo;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by dongxu on 2017/2/15.
 */
public interface ScheduleMenuInfoDao extends CrudRepository<ScheduleMenuInfo,Long>{
    List<ScheduleMenuInfo> findByScheduleDayAndTypeMenuOrderByTimeMenu(String day, String typeMenu);

    List<ScheduleMenuInfo> findByScheduleDayAndTimeMenuAndTypeMenuOrderByTimeMenu(String day, String timeMenu, String typeMenu);
}
