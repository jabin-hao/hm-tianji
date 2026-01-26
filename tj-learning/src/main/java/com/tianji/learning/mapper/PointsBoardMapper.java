package com.tianji.learning.mapper;

import com.tianji.learning.domain.po.PointsBoard;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Insert;

/**
 * <p>
 * 学霸天梯榜 Mapper 接口
 * </p>
 *
 * @author fenny
 * @since 2023-11-29
 */
public interface PointsBoardMapper extends BaseMapper<PointsBoard> {

    /**
     * 创建榜单表，表名格式为points_board_{赛季id}
     * @param tableName 新表名
     */
    @Insert("""
             CREATE TABLE `${tableName}`
                    (
                        `id`      BIGINT NOT NULL AUTO_INCREMENT COMMENT '榜单id',
                        `user_id` BIGINT NOT NULL COMMENT '学生id',
                        `points`  INT    NOT NULL COMMENT '积分值',
                        PRIMARY KEY (`id`) USING BTREE,
                        INDEX `idx_user_id` (`user_id`) USING BTREE
                    )
                        COMMENT ='学霸天梯榜'
                        COLLATE = 'utf8mb4_0900_ai_ci'
                        ENGINE = InnoDB
                        ROW_FORMAT = DYNAMIC\
            """)
    void createPointsBoardTable(String tableName);
}
