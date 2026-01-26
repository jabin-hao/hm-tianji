package com.tianji.common.utils;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * 集合工具类 - 补充CollUtils中没有的常用方法
 */
public class CollectionUtils {
    
    /**
     * 将集合转换为以指定字段为 key 的 Map
     * @param collection 源集合
     * @param keyExtractor key 提取器
     * @param <T> 集合元素类型
     * @param <K> key 类型
     * @return 转换后的 Map
     */
    public static <T, K> Map<K, T> toMap(Collection<T> collection, Function<T, K> keyExtractor) {
        if (CollUtils.isEmpty(collection)) {
            return Collections.emptyMap();
        }
        return collection.stream().collect(Collectors.toMap(keyExtractor, Function.identity()));
    }
    
    /**
     * 将集合转换为以指定字段为key，另一字段为value的Map
     * @param collection 源集合
     * @param keyExtractor key 提取器
     * @param valueExtractor value 提取器
     * @param <T> 集合元素类型
     * @param <K> key 类型
     * @param <V> value 类型
     * @return 转换后的 Map
     */
    public static <T, K, V> Map<K, V> toMap(Collection<T> collection, Function<T, K> keyExtractor, Function<T, V> valueExtractor) {
        if (CollUtils.isEmpty(collection)) {
            return Collections.emptyMap();
        }
        return collection.stream().collect(Collectors.toMap(keyExtractor, valueExtractor));
    }
    
    /**
     * 提取集合中指定字段的值，组成新的集合
     * @param collection 源集合
     * @param extractor 字段提取器
     * @param <T> 源集合元素类型
     * @param <R> 目标集合元素类型
     * @return 新的集合
     */
    public static <T, R> List<R> extractToList(Collection<T> collection, Function<T, R> extractor) {
        if (CollUtils.isEmpty(collection)) {
            return Collections.emptyList();
        }
        return collection.stream().map(extractor).collect(Collectors.toList());
    }
    
    /**
     * 提取集合中指定字段的值，组成Set去重
     * @param collection 源集合
     * @param extractor 字段提取器
     * @param <T> 源集合元素类型
     * @param <R> 目标集合元素类型
     * @return 新的 Set
     */
    public static <T, R> Set<R> extractToSet(Collection<T> collection, Function<T, R> extractor) {
        if (CollUtils.isEmpty(collection)) {
            return Collections.emptySet();
        }
        return collection.stream().map(extractor).collect(Collectors.toSet());
    }
}