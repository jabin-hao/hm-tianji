package com.tianji.course.domain.po;

import lombok.Data;

/**
 * 查询某个课程中练习对应的练习id和该练习对应的题目 id
 * @author wusongsong
 * @since 2022/7/22 16:04
 * @version 1.0.0
 **/
@Data
public class CataIdAndSubScore {
    //目录 id
    private Long cataId;
    //题目 id
    private Long subjectId;
    //题目对应的分
    private Integer score;
}
