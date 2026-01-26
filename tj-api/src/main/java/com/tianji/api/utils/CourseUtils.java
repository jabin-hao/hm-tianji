package com.tianji.api.utils;

import com.tianji.api.client.trade.TradeClient;import com.tianji.common.utils.CollUtils;

import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * 课程相关工具类
 */
public class CourseUtils {
    
    /**
     * 获取课程报名人数映射
     * @param tradeClient 交易客户端
     * @param courseIds 课程 ID列表
     * @return 课程 ID到报名人数的映射
     */
    public static Map<Long, Integer> getEnrollmentCountMap(TradeClient tradeClient, List<Long> courseIds) {
        if (CollUtils.isEmpty(courseIds)) {
            return Collections.emptyMap();
        }
        return tradeClient.countEnrollNumOfCourse(courseIds);
    }
    
    /**
     * 获取单个课程的报名人数
     * @param tradeClient 交易客户端
     * @param courseId 课程 ID
     * @return 报名人数
     */
    public static Integer getSingleCourseEnrollment(TradeClient tradeClient, Long courseId) {
        if (courseId == null) {
            return 0;
        }
        Map<Long, Integer> enrollmentMap = getEnrollmentCountMap(tradeClient, CollUtils.singletonList(courseId));
        return enrollmentMap.getOrDefault(courseId, 0);
    }
}