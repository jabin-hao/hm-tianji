package com.tianji.common.utils;

import com.tianji.common.exceptions.CommonException;
import lombok.extern.slf4j.Slf4j;

/**
 * 重试工具类
 */
@Slf4j
public class RetryUtils {
    
    /**
     * 带重试的操作执行
     * @param operation 要执行的操作
     * @param maxRetries 最大重试次数
     * @param shouldRetry 是否应该重试的判断逻辑
     * @param errorMessage 失败时的错误信息
     * @param <T> 返回值类型
     * @param <E> 异常类型
     * @return 操作结果
     */
    public static <T, E extends Exception> T executeWithRetry(
            SupplierWithException<T, E> operation,
            int maxRetries,
            java.util.function.Predicate<E> shouldRetry,
            String errorMessage) {
        
        E lastException = null;
        int attempt = 0;
        
        while (attempt < maxRetries) {
            try {
                return operation.get();
            } catch (Exception e) {
                @SuppressWarnings("unchecked")
                E typedException = (E) e;
                lastException = typedException;
                
                if (shouldRetry.test(typedException)) {
                    attempt++;
                    if (log.isDebugEnabled()) {
                        log.debug("操作失败，进行第{}次重试: {}", attempt, e.getMessage());
                    }
                    continue;
                }
                
                // 不应该重试，直接抛出异常
                throw new CommonException(errorMessage, e);
            }
        }
        
        // 重试次数用完，抛出最后一次的异常
        throw new CommonException(errorMessage, lastException);
    }
    
    /**
     * 支持抛出异常的 Supplier接口
     */
    @FunctionalInterface
    public interface SupplierWithException<T, E extends Exception> {
        T get() throws E;
    }
}