package com.ypy.graduationProject.common;

import java.io.File;
import java.io.FileOutputStream;

public class FileUtil {
	/**
	 * 上传文件
	 * @param file
	 * @param filePath
	 * @param fileName
	 * @throws Exception
	 */
	public static void uploadFile(byte[] file, String filePath, String fileName) throws Exception { 
        File targetFile = new File(filePath);  
        if(!targetFile.exists()){    //如果不存在就创建
            targetFile.mkdirs();    
        }       
        FileOutputStream out = new FileOutputStream(filePath+fileName);
        out.write(file);
        out.flush();
        out.close();
    }
	
	/**
	 * 去除后缀名
	 * @param str
	 * @return
	 */
	public static String wipeOffSuffix(String str) {
		return str.substring(0, str.indexOf("."));
	}
	
	/**
	 * 将路径处理为文件名
	 * @param str
	 * @return
	 */
	public static String handlePathToFileName(String str) {
		while (str.contains("\\")) {
			str = str.substring(str.indexOf("\\")+1,str.length());
    	}
		return str;
	}
	
	/**
	 * 判断是否是要求的题目名称
	 * @param fileName
	 * @return
	 */
	public static boolean isCorrectEndFileName(String fileName) {
		for (int i=0; i<Const.DOCUMENT_NAME.length; i++) {
			if (fileName.endsWith(Const.DOCUMENT_NAME[i])) {
				return true;
			}
		}
		return false;
	}
}
