package com.dean.util;

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
public class ZxingUtils {
    public static void createImg(String linkPath,String rootPath,String fileName){
        int width = 100;
        int height = 100;
        String format = "png";
        Hashtable hints = new Hashtable();
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.M);
        hints.put(EncodeHintType.MARGIN, 2);
        try {
            BitMatrix bitMatrix = new MultiFormatWriter().encode(linkPath, BarcodeFormat.QR_CODE, width, height, hints);
            Path file = new File(rootPath+fileName).toPath();
            try {
                MatrixToImageWriter.writeToPath(bitMatrix, format, file);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (WriterException e) {
            e.printStackTrace();
        }
    }

}
