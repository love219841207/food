package com.dean.service.impl;

import com.dean.dao.AddressInfoDao;
import com.dean.dao.PkgMenuDao;
import com.dean.dao.ScheduleMenuInfoDao;
import com.dean.domain.AddressInfo;
import com.dean.domain.DataDictionary;
import com.dean.domain.PkgMenu;
import com.dean.domain.ScheduleMenuInfo;
import com.dean.service.*;
import com.dean.util.Constants;
import com.dean.util.DateUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by dongxu on 2017/2/14.
 */
@Service
public class MenuServiceImpl implements MenuService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private DataDictionaryService dataDictionaryService;
    @Autowired
    private ScheduleMenuInfoDao scheduleMenuInfoDao;
    @Autowired
    private PkgMenuDao pkgMenuDao;
    @Autowired
    private AddressInfoDao addressInfoDao;

    public List<TypeMenuVO> findTypeMenu() {
        List<DataDictionary> list = dataDictionaryService.findTypeMenu();
        List<TypeMenuVO> ls = new ArrayList<TypeMenuVO>();
        TypeMenuVO typeMenuVO = null;
        for (DataDictionary d : list) {
            typeMenuVO = new TypeMenuVO();
            typeMenuVO.setName(d.getName());
            typeMenuVO.setId(d.getVal());
            typeMenuVO.setImgPath("typemenu" + d.getVal() + ".jpg");
            ls.add(typeMenuVO);
        }
        return ls;
    }

    @Override
    public List<TimeMenuVO> findTimeMenu() {
        List<DataDictionary> list = dataDictionaryService.findTimeMenu();
        List<TimeMenuVO> ls = new ArrayList<TimeMenuVO>();
        TimeMenuVO timeMenuVO = null;
        for (DataDictionary d : list) {
            timeMenuVO = new TimeMenuVO();
            timeMenuVO.setName(d.getName());
            timeMenuVO.setId(d.getVal());
            ls.add(timeMenuVO);
        }
        return ls;
    }

    @Override
    public void initMenuFromExcel() throws IOException, InvalidFormatException {
        List<ArrayList<ArrayList<String>>> excelInfo = this.ReadMenuFormExcel();
        if(excelInfo.size()!=2){
            logger.info("解析menuexcel异常,sheet数量不对");
        }else{
            List<TypeMenuVO> typeMenus = this.findTypeMenu();
            List<TimeMenuVO> timeMenus = this.findTimeMenu();
            ArrayList<ArrayList<String>> menuInfos = excelInfo.get(0);
            List<ScheduleMenuInfo> scheduleMenuInfos = new ArrayList<ScheduleMenuInfo>();
            ScheduleMenuInfo scheduleMenuInfo = null;
            String scheduleDayTmp = "";
            String typeMenu = "";
            for (ArrayList<String> al : menuInfos){
                if(!StringUtils.isEmpty(al.get(0))){
                    scheduleDayTmp = al.get(0);
                }
                if(!StringUtils.isEmpty(al.get(1))){
                    typeMenu = al.get(1);
                }
                scheduleMenuInfo =  new ScheduleMenuInfo();

                scheduleMenuInfo.setScheduleDay(DateUtils.getDate(scheduleDayTmp));
                String typeMenuVal = this.getTypeMenuVal(typeMenu, typeMenus);
                String timeMenuVal = this.getTimeMenuVal(al.get(2), timeMenus);
                if(StringUtils.isEmpty(typeMenuVal)||StringUtils.isEmpty(timeMenuVal)){
                    logger.info("解析menuexcel异常排餐,typeMenuVal==null||timeMenuVal==null");
                }
                scheduleMenuInfo.setTypeMenu(typeMenuVal);
                scheduleMenuInfo.setTimeMenu(timeMenuVal);
                scheduleMenuInfo.setMainInfo(al.get(3));
                scheduleMenuInfo.setMinor(al.get(4));
                scheduleMenuInfo.setCoarseGrain(al.get(5));
                scheduleMenuInfo.setStapleFood(al.get(6));
                scheduleMenuInfo.setDrink(al.get(7));
                scheduleMenuInfo.setOther(al.get(8));
                scheduleMenuInfo.setKcal(al.get(9));
                scheduleMenuInfo.setImgPaths(al.get(10));
                scheduleMenuInfo.setUpdateTime(new Date());
                scheduleMenuInfos.add(scheduleMenuInfo);
            }

            List<PkgMenu> pkgMenus = new ArrayList<PkgMenu>();
            PkgMenu pkgMenu = null;
            typeMenu = "";
            ArrayList<ArrayList<String>> pkgMenuexcewls = excelInfo.get(1);
            for (ArrayList<String> al : pkgMenuexcewls){
                pkgMenu = new PkgMenu();
                if(!StringUtils.isEmpty(al.get(0))){
                    typeMenu = al.get(0);
                }
                String typeMenuVal = this.getTypeMenuVal(typeMenu, typeMenus);
                String timeMenuVal = this.getTimeMenuVal(al.get(1), timeMenus);
                if(StringUtils.isEmpty(typeMenuVal)||StringUtils.isEmpty(timeMenuVal)){
                    logger.info("解析menuexcel异常方案设置,typeMenuVal==null||timeMenuVal==null");
                }
                pkgMenu.setTypeMenu(typeMenuVal);
                pkgMenu.setTimeMenu(timeMenuVal);
                pkgMenu.setPkgMenu(al.get(2));
                pkgMenu.setPkgDays(Double.valueOf(al.get(3)).intValue());
                pkgMenu.setOriginalPrice(new BigDecimal(al.get(4)).setScale(2));
                pkgMenu.setSalePrice(new BigDecimal(al.get(5)).setScale(2));
                pkgMenu.setUpdateTime(new Date());
                pkgMenus.add(pkgMenu);
            }

           /* List<AddressInfo> addressInfos = new ArrayList<AddressInfo>();
            AddressInfo addressInfo = null;
            ArrayList<ArrayList<String>> addressexcels = excelInfo.get(2);
            for (ArrayList<String> al : addressexcels){
                addressInfo = new AddressInfo();
                if(!StringUtils.isEmpty(al.get(0))){
                    addressInfo.setAddress(al.get(0));
                }
                addressInfos.add(addressInfo);
            }*/

            this.updateDateFromExcel(scheduleMenuInfos,pkgMenus);
        }

    }

    @Override
    public List<MenuInfoVO> findMenuDetail(String day, String typeMenu) {
        List<ScheduleMenuInfo> list = scheduleMenuInfoDao.findByScheduleDayAndTypeMenuOrderByTimeMenu(DateUtils.getDate(day), typeMenu);
        List<TimeMenuVO> timeMenus = this.findTimeMenu();
        List<MenuInfoVO> menus = new ArrayList<MenuInfoVO>();
        MenuInfoVO menuInfoVO = null;
        for (ScheduleMenuInfo smi : list){
            menuInfoVO = new MenuInfoVO();
            menuInfoVO.setTimeMenu(this.getTimeMenuName(smi.getTimeMenu(), timeMenus));
            menuInfoVO.setTimeMenuVal(smi.getTimeMenu());
            menuInfoVO.setTypeMenu(smi.getTypeMenu());
            menuInfoVO.setCoarseGrain(smi.getCoarseGrain());
            menuInfoVO.setDrink(smi.getDrink());
            menuInfoVO.setId(smi.getId());
            menuInfoVO.setKcal(smi.getKcal());
            menuInfoVO.setMainInfo(smi.getMainInfo());
            menuInfoVO.setMinor(smi.getMinor());
            menuInfoVO.setOther(smi.getOther());
            menuInfoVO.setScheduleDay(DateUtils.getStringDate(smi.getScheduleDay()));
            menuInfoVO.setStapleFood(smi.getStapleFood());
            menuInfoVO.setImgs(smi.getImgPaths());
            menuInfoVO.setPkgMenuVOs(this.findPkgMenuVO(typeMenu, smi.getTimeMenu()));
            menus.add(menuInfoVO);
        }
        return menus;
    }

    @Override
    public List<Date> findFixDate(int nextOffset) {
        List<Date> ls = scheduleMenuInfoDao.findNextFixDate(nextOffset);
        return ls;
    }

    private List<PkgMenuVO> findPkgMenuVO(String typeMenu,String timeMenu) {
        List<PkgMenuVO> pkgMenuVOs = new ArrayList<PkgMenuVO>();
        List<PkgMenu> pkgMenus = pkgMenuDao.findByTypeMenuAndTimeMenuOrderByTimeMenu(typeMenu, timeMenu);
        PkgMenuVO pkgMenuVO = null;
        for (PkgMenu pkgMenu : pkgMenus){
            pkgMenuVO = new PkgMenuVO();
            pkgMenuVO.setId(pkgMenu.getId());
            pkgMenuVO.setOriginalPrice(pkgMenu.getOriginalPrice());
            pkgMenuVO.setSalePrice(pkgMenu.getSalePrice());
            pkgMenuVO.setTypeMenu(pkgMenu.getTypeMenu());
            pkgMenuVO.setPkgMenu(pkgMenu.getPkgMenu());
            pkgMenuVO.setPkgDays(pkgMenu.getPkgDays());
            pkgMenuVOs.add(pkgMenuVO);
        }
        return pkgMenuVOs;
    }


    @Transactional
    private void updateDateFromExcel(List<ScheduleMenuInfo> scheduleMenuInfos,List<PkgMenu> pkgMenus){
        logger.info("跟新排餐、套餐配置属性,start...");
        impScheduleMenu(scheduleMenuInfos);
        pkgMenuDao.deleteAll();
        pkgMenuDao.save(pkgMenus);
        /*addressInfoDao.deleteAll();
        addressInfoDao.save(addressInfos);*/
        logger.info("跟新排餐、套餐配置属性,...");
    }

    @Transactional
    private void impScheduleMenu(List<ScheduleMenuInfo> scheduleMenuInfos){
        List<ScheduleMenuInfo> ls = null;
        for(ScheduleMenuInfo s : scheduleMenuInfos){
            ls = scheduleMenuInfoDao.findByScheduleDayAndTimeMenuAndTypeMenuOrderByTimeMenu(s.getScheduleDay(),s.getTimeMenu(),s.getTypeMenu());
            if(ls.size()>0){
                s.setId(ls.get(0).getId());
            }
        }
        scheduleMenuInfoDao.save(scheduleMenuInfos);
    }

    private String getTypeMenuVal(String name,List<TypeMenuVO> typeMenus){
        for(TypeMenuVO tm : typeMenus){
            if(tm.getName().equals(name)){
                return tm.getId();
            }
        }
        return null;
    }

    private String getTimeMenuVal(String name,List<TimeMenuVO> timeMenus){
        for(TimeMenuVO tm : timeMenus){
            if(tm.getName().equals(name)){
                return tm.getId();
            }
        }
        return null;
    }

    private String getTimeMenuName(String id,List<TimeMenuVO> timeMenus){
        for(TimeMenuVO tm : timeMenus){
            if(tm.getId().equals(id)){
                return tm.getName();
            }
        }
        return null;
    }

    private List<ArrayList<ArrayList<String>>> ReadMenuFormExcel() {
        List<ArrayList<ArrayList<String>>> excelInfo = new ArrayList<ArrayList<ArrayList<String>>>();
        File file = new File("E:\\menu.xlsx");
        Workbook workbook = null;
        try {
            workbook = WorkbookFactory.create(file);
        } catch (IOException e) {
            logger.error("解析menuexcel错误[{}]", e);
        } catch (InvalidFormatException e) {
            logger.error("解析menuexcel错误[{}]", e);
        }
        int sheetCount = workbook.getNumberOfSheets();  //Sheet的数量
        logger.info("sheet数量为[{}]", sheetCount);
        ArrayList<ArrayList<String>> excelSheet = null;
        //遍历每个Sheet
        for (int s = 0; s < sheetCount; s++) {
            excelSheet = new ArrayList<ArrayList<String>>();

            Sheet sheet = workbook.getSheetAt(s);
            int rowCount = sheet.getPhysicalNumberOfRows(); //获取总行数
            ArrayList<String> excelRow = null;
            //遍历每一行
            for (int r = 1; r < rowCount; r++) {
                excelRow = new ArrayList<String>();
                Row row = sheet.getRow(r);
                int cellCount = row.getPhysicalNumberOfCells(); //获取总列数
                //遍历每一列
                for (int c = 0; c < cellCount; c++) {
                    Cell cell = row.getCell(c);
                    int cellType = cell.getCellType();
                    String cellValue = null;
                    switch (cellType) {
                        case Cell.CELL_TYPE_STRING: //文本
                            cellValue = cell.getStringCellValue();
                            break;
                        case Cell.CELL_TYPE_NUMERIC: //数字、日期
                            if (DateUtil.isCellDateFormatted(cell)) {
                                cellValue = Constants.fmt.format(cell.getDateCellValue()); //日期型
                            } else {
                                cellValue = String.valueOf(cell.getNumericCellValue()); //数字
                            }
                            break;
                        case Cell.CELL_TYPE_BOOLEAN: //布尔型
                            cellValue = String.valueOf(cell.getBooleanCellValue());
                            break;
                        case Cell.CELL_TYPE_BLANK: //空白
                            cellValue = cell.getStringCellValue();
                            break;
                        case Cell.CELL_TYPE_ERROR: //错误
                            cellValue = "错误";
                            break;
                        case Cell.CELL_TYPE_FORMULA: //公式
                            cellValue = "错误";
                            break;
                        default:
                            cellValue = "错误";
                    }
                    System.out.print(cellValue + "    |");
                    excelRow.add(cellValue);
                }
                System.out.println("");
                excelSheet.add(excelRow);
            }
            excelInfo.add(excelSheet);
        }

        logger.info("***********************************************");

        for (int i = 0; i < excelInfo.size(); i++) {
            ArrayList<ArrayList<String>> ls = excelInfo.get(i);
            for (int j = 0; j < ls.size(); j++) {
                ArrayList<String> f = ls.get(j);
                for (String s : f) {
                    System.out.print("|");
                    System.out.print(s.length() == 0 ? "***********" : s);
                    System.out.print("|");
                }
                System.out.println();
            }
            System.out.println("************************************");
        }
        return excelInfo;
    }
}
