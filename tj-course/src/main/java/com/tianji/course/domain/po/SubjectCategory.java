package com.tianji.course.domain.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serial;
import java.io.Serializable;

/**
 * <p>
 * 课程分类关系表
 * </p>
 *
 * @author wusongsong
 * @since 2022-07-15
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("subject_category")
public class SubjectCategory implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 题目 id
     */
    private Long subjectId;

    /**
     * 一级课程分类 id
     */
    private Long firstCateId;

    /**
     * 二级课程分类 id
     */
    private Long secondCateId;

    /**
     * 三级课程分类 id
     */
    private Long thirdCateId;


}
