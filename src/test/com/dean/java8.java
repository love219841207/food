package com.dean;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by dongxu on 2017/3/6.
 */
public class java8 {
    public static void main(String[] arg0) throws ParseException {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String str1 = "2017-07-02";
        String str2 = "2017-07-03";
        String str3 = "2017-07-04";
        Date d1 = format.parse(str1);
        Date d2 = format.parse(str2);
        List<Date> list1 = new ArrayList<Date>();
        list1.add(d1);
        list1.add(d2);

        com.dean.MyClass myClass11 = new MyClass();
        MyClass myClass22 = new MyClass();
        Date d11 = format.parse(str1);
        Date d22 = format.parse(str3);
        myClass11.setDate(d11);
        myClass11.setStr("d11");
        myClass22.setDate(d22);
        myClass22.setStr("d22");
        List<MyClass> list11 = new ArrayList<MyClass>();
        list11.add(myClass11);
        list11.add(myClass22);
        Map<Date,MyClass> maps = list11.stream().collect(Collectors.toMap(MyClass::getDate,(p)-> p));
        for(Date d : list1){
            if(maps.get(d)!=null){
                System.out.println(maps.get(d).getStr());
            }
        }

    }


}
