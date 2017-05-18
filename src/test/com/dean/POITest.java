package com.dean;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by dongxu on 2017/2/14.
 */
public class POITest {
    protected static final Logger logger = LoggerFactory.getLogger(POITest.class);
    private static  SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
   /* public static void main(String[] arg0) throws IOException, InvalidFormatException {
        File file = new File("E:\\menu.xlsx");
        Workbook workbook = WorkbookFactory.create(file);
        int sheetCount = workbook.getNumberOfSheets();  //Sheet的数量
        logger.info("sheet数量为[{}]",sheetCount);
        //遍历每个Sheet
        for (int s = 0; s < sheetCount; s++) {
            Sheet sheet = workbook.getSheetAt(s);
            int rowCount = sheet.getPhysicalNumberOfRows(); //获取总行数
            //遍历每一行
            for (int r = 0; r < rowCount; r++) {
                Row row = sheet.getRow(r);
                int cellCount = row.getPhysicalNumberOfCells(); //获取总列数
                //遍历每一列
                for (int c = 0; c < cellCount; c++) {
                    Cell cell = row.getCell(c);
                    int cellType = cell.getCellType();
                    String cellValue = null;
                    switch(cellType) {
                        case Cell.CELL_TYPE_STRING: //文本
                            cellValue = cell.getStringCellValue();
                            break;
                        case Cell.CELL_TYPE_NUMERIC: //数字、日期
                            if(DateUtil.isCellDateFormatted(cell)) {
                                cellValue = fmt.format(cell.getDateCellValue()); //日期型
                            }
                            else {
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
                }
                System.out.println("");
            }
        }*/

    public static void main(String[] arg0) throws IOException, InvalidFormatException {
        List<ArrayList<ArrayList<String>>> excelInfo = new ArrayList<ArrayList<ArrayList<String>>>();
        File file = new File("E:\\menu.xlsx");
        Workbook workbook = WorkbookFactory.create(file);
        int sheetCount = workbook.getNumberOfSheets();  //Sheet的数量
        logger.info("sheet数量为[{}]",sheetCount);
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
                    if(s==2){
                        System.out.println(1);
                    }
                    switch(cellType) {
                        case Cell.CELL_TYPE_STRING: //文本
                            cellValue = cell.getStringCellValue();
                            break;
                        case Cell.CELL_TYPE_NUMERIC: //数字、日期
                            if(DateUtil.isCellDateFormatted(cell)) {
                                cellValue = fmt.format(cell.getDateCellValue()); //日期型
                            }
                            else {
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
        //logger.info(excelInfo.size());
        //System.out.print(excelInfo.size());

       // List<ArrayList<ArrayList<String>>> excelInfo = new ArrayList<ArrayList<ArrayList<String>>>();
        for(int i = 0;i<excelInfo.size();i++){
            ArrayList<ArrayList<String>> ls = excelInfo.get(i);
            for(int j =0 ;j<ls.size();j++){
                ArrayList<String> f = ls.get(j);
                for(String s : f){
                    System.out.print("|");
                    System.out.print(s.length()==0?"***********":s);
                    System.out.print("|");
                }
                System.out.println();
            }
            System.out.println("************************************");
        }

    }
}
