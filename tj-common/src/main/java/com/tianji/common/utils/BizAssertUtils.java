package com.tianji.common.utils;

import com.tianji.common.exceptions.BadRequestException;
import com.tianji.common.exceptions.BizIllegalException;

/**
 * 业务数据校验工具类 - 补充AssertUtils中没有的业务场景校验
 */
public class BizAssertUtils {
    
    /**
     * 断言对象不为空，否则抛出BadRequestException
     * @param object 要校验的对象
     * @param message 错误信息
     */
    public static void notNull(Object object, String message) {
        if (object == null) {
            throw new BadRequestException(message);
        }
    }
    
    /**
     * 断言对象不为空，否则抛出BizIllegalException
     * @param object 要校验的对象
     * @param message 错误信息
     */
    public static void notNullBiz(Object object, String message) {
        if (object == null) {
            throw new BizIllegalException(message);
        }
    }
    
    /**
     * 断言条件为真，否则抛出BadRequestException
     * @param condition 条件
     * @param message 错误信息
     */
    public static void isTrue(boolean condition, String message) {
        if (!condition) {
            throw new BadRequestException(message);
        }
    }
    
    /**
     * 断言条件为真，否则抛出BizIllegalException
     * @param condition 条件
     * @param message 错误信息
     */
    public static void isTrueBiz(boolean condition, String message) {
        if (!condition) {
            throw new BizIllegalException(message);
        }
    }
}