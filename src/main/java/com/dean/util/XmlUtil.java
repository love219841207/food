package com.dean.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.io.StringReader;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by dongxu on 2017/2/23.
 */
public class XmlUtil {
    protected final static Logger logger = LoggerFactory.getLogger(XmlUtil.class);
      public static Map<String,String> resolve(String xml){
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = null;
        try {
            builder = factory.newDocumentBuilder();
        } catch (ParserConfigurationException e) {
            logger.error(e.getMessage());
        }
        Document document = null;
        StringReader read = new StringReader(xml);
        InputSource is = new InputSource(read);
        try {
            document = builder.parse(is);
        } catch (SAXException e) {
            logger.error(e.getMessage());
            e.printStackTrace();
        } catch (IOException e) {
            logger.error(e.getMessage());
            e.printStackTrace();
        }
        Element element = document.getDocumentElement();
        NodeList nodes = element.getChildNodes();
        Map<String,String> map = new HashMap<String, String>();
        String name = "";
        String text = "";
          logger.info("=====================XML BODY START=============================");
        for(int j=0;j<nodes.getLength();j++){
            name = nodes.item(j).getNodeName();
            text = nodes.item(j).getTextContent();
            if("".equals(name)||"".equals(text)){
                continue;
            }
            map.put(name, text);
        }
          logger.info("===================XML BODY END===============================");
        return map;
    }

}
