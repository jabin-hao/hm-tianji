package com.tianji.common.utils;

/**
 * 文件工具类
 */
public class FileUtils {
    
    /**
     * 根据文件名获取文件扩展名
     * @param filename 文件名
     * @return 文件扩展名（小写），如果没有扩展名则返回空字符串
     */
    public static String getFileExtension(String filename) {
        if (StringUtils.isBlank(filename)) {
            return "";
        }
        int lastDotIndex = filename.lastIndexOf('.');
        if (lastDotIndex > 0 && lastDotIndex < filename.length() - 1) {
            return filename.substring(lastDotIndex + 1).toLowerCase();
        }
        return "";
    }
    
    /**
     * 根据文件名获取文件名（不含扩展名）
     * @param filename 文件名
     * @return 不含扩展名的文件名
     */
    public static String getFileNameWithoutExtension(String filename) {
        if (StringUtils.isBlank(filename)) {
            return "";
        }
        int lastDotIndex = filename.lastIndexOf('.');
        if (lastDotIndex > 0) {
            return filename.substring(0, lastDotIndex);
        }
        return filename;
    }
}
