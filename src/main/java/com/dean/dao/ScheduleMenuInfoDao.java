package com.dean.dao;

import com.dean.domain.ScheduleMenuInfo;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/2/15.
 */
public interface ScheduleMenuInfoDao extends CrudRepository<ScheduleMenuInfo,Long>{
    List<ScheduleMenuInfo> findByScheduleDayAndTypeMenuOrderByTimeMenu(Date day, String typeMenu);

    List<ScheduleMenuInfo> findByScheduleDayAndTimeMenuAndTypeMenuOrderByTimeMenu(Date day, String timeMenu, String typeMenu);

    @Query(value = "select DISTINCT t.schedule_day from schedule_menu_info t where t.schedule_day>CURDATE() ORDER BY t.schedule_day LIMIT ?1",nativeQuery = true)
    List<Date> findNextFixDate(int next);

    @Query(value = "select DISTINCT t.schedule_day from schedule_menu_info t where t.schedule_day>CURDATE()+1 ORDER BY t.schedule_day LIMIT ?1",nativeQuery = true)
    List<Date> findNextFixDateExt(int next);
}
