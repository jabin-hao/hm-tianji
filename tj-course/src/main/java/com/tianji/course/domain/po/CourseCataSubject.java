package com.tianji.course.domain.po;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serial;
import java.io.Serializable;

/**
 * <p>
 * 课程-题目关系表草稿
 * </p>
 *
 * @author wusongsong
 * @since 2022-07-20
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("course_cata_subject")
public class CourseCataSubject implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 小节题目关系 id
     */
    private Long id;

    /**
     * 课程 id
     */
    private Long courseId;

    /**
     * 小节 id
     */
    private Long cataId;

    /**
     * 题目 id
     */
    private Long subjectId;
}
