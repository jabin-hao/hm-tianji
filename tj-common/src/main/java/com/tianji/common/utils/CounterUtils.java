package com.tianji.common.utils;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

/**
 * 计数统计工具类
 */
public class CounterUtils {
    
    /**
     * 对集合中的元素按照指定字段进行计数统计
     * @param collection 源集合
     * @param keyExtractor key提取器，用于提取计数的字段
     * @param <T> 集合元素类型
     * @param <K> key 类型
     * @return 计数结果映射
     */
    public static <T, K> Map<K, Integer> countBy(Collection<T> collection, Function<T, K> keyExtractor) {
        Map<K, Integer> countMap = new HashMap<>();
        if (CollUtils.isEmpty(collection)) {
            return countMap;
        }
        
        for (T item : collection) {
            K key = keyExtractor.apply(item);
            if (key != null) {
                countMap.compute(key, (k, count) -> count == null ? 1 : count + 1);
            }
        }
        return countMap;
    }
    
    /**
     * 对集合中的元素按照多个字段进行计数统计
     * @param collection 源集合
     * @param keyExtractors key提取器数组，用于提取计数的字段
     * @param <T> 集合元素类型
     * @param <K> key 类型
     * @return 计数结果映射
     */
    @SafeVarargs
    public static <T, K> Map<K, Integer> countByMultiple(Collection<T> collection, Function<T, K>... keyExtractors) {
        Map<K, Integer> countMap = new HashMap<>();
        if (CollUtils.isEmpty(collection) || keyExtractors.length == 0) {
            return countMap;
        }
        
        for (T item : collection) {
            for (Function<T, K> keyExtractor : keyExtractors) {
                K key = keyExtractor.apply(item);
                if (key != null) {
                    countMap.compute(key, (k, count) -> count == null ? 1 : count + 1);
                }
            }
        }
        return countMap;
    }
}