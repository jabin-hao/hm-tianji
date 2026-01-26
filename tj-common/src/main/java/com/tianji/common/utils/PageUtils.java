package com.tianji.common.utils;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tianji.common.domain.dto.PageDTO;

/**
 * 分页工具类
 */
public class PageUtils {
    
    /**
     * 检查分页结果是否为空，如果为空则返回空的PageDTO
     * @param page MyBatis Plus的分页对象
     * @param <T> 记录类型
     * @return 如果有记录返回null，如果无记录返回空的PageDTO
     */
    public static <T> PageDTO<T> checkAndReturnEmptyIfNeeded(Page<T> page) {
        if (CollUtils.isEmpty(page.getRecords())) {
            return PageDTO.empty(page);
        }
        return null; // 表示有数据，继续处理
    }
    
    /**
     * 安全的分页结果检查，返回是否有数据
     * @param page 分页对象
     * @param <T> 记录类型
     * @return 如果有数据返回true，否则返回false
     */
    public static <T> boolean hasRecords(Page<T> page) {
        return page != null && CollUtils.isNotEmpty(page.getRecords());
    }
}