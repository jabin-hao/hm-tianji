package com.tianji.common.utils;

import cn.hutool.core.util.ObjectUtil;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.Field;
import java.math.BigDecimal;

/**
 * Object 操作工具
 **/
@Slf4j
public class ObjectUtils extends ObjectUtil {

    /**
     * 为object设置默认值，对target中的基本类型进行默认值初始化,
     * 为null的对象不操作
     *
     * @param target 需要初始化的对象
     */
    public static void setDefault(Object target) {
        if (target == null) {
            return;
        }
        Class<?> clazz = target.getClass();
        Field[] declaredFields = clazz.getDeclaredFields();
        for (Field field : declaredFields) {
            setDefault(field, target);
        }

    }

    /**
     * 给某个字段设置为默认值
     */
    private static void setDefault(Field field, Object target) {
        field.setAccessible(true);
        try {
            Object value = field.get(target);
            if (value != null) {
                return;
            }
            String type = field.getGenericType().toString();
            Object defaultValue = switch (type) {
                case "class java.lang.String", "class java.lang.Character" -> "";
                case "class java.lang.Double" -> 0.0d;
                case "class java.lang.Long" -> 0L;
                case "class java.lang.Short" -> (short) 0;
                case "class java.lang.Integer" -> 0;
                case "class java.lang.Float" -> 0f;
                case "class java.lang.Byte" -> (byte) 0;
                case "class java.math.BigDecimal" -> BigDecimal.ZERO;
                case "class java.lang.Boolean" -> Boolean.FALSE;
                default -> null;
            };
            field.set(target, defaultValue);
        } catch (Exception e) {
            log.error("error: {}",e.getMessage());
        }
    }
}
