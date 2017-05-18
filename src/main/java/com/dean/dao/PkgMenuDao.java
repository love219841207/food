package com.dean.dao;

import com.dean.domain.PkgMenu;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by dongxu on 2017/2/15.
 */
public interface PkgMenuDao extends CrudRepository<PkgMenu,Long>{
    List<PkgMenu> findByTypeMenuAndTimeMenuOrderByTimeMenu(String typeMenu, String timeMenu);


    List<PkgMenu> findByTypeMenuAndTimeMenuAndPkgDaysOrderByTimeMenu(String typeMenu, String timeMenu, int pkgDays);
}
