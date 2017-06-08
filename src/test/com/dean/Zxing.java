package com.dean;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.Hashtable;

/**
 * Created by dongxu on 2017/6/5.
 */
public class Zxing {
    public static void main(String[] aerg0) {
        String text = "www.baidu.com";
        int width = 100;
        int height = 100;
        String format = "png";
        Hashtable hints = new Hashtable();
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.M);
        hints.put(EncodeHintType.MARGIN, 2);
        try {
            BitMatrix bitMatrix = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height, hints);
            Path file = new File("E:/new.jpg").toPath();
            try {
                MatrixToImageWriter.writeToPath(bitMatrix, format, file);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (WriterException e) {
// TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}