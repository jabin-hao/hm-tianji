package com.tianji.learning.controller;


import com.tianji.common.domain.dto.PageDTO;
import com.tianji.common.domain.query.PageQuery;
import com.tianji.common.utils.UserContext;
import com.tianji.learning.domain.dto.LearningPlanDTO;
import com.tianji.learning.domain.vo.LearningLessonVO;
import com.tianji.learning.domain.vo.LearningPlanPageVO;
import com.tianji.learning.domain.vo.LessonStatusVO;
import com.tianji.learning.service.ILearningLessonService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 学生课程表 前端控制器
 * </p>
 *
 * @author fenny
 * @since 2023-11-20
 */
@Tag(name = "我的课程相关接口")
@RequiredArgsConstructor
@RestController
@RequestMapping("/lessons")
public class LearningLessonController {

    private final ILearningLessonService lessonService;

    /**
     * 分页查询用户购买的课程
     * @param query 自定义分页参数
     * @return 包含了 LearningLessonVO的自定义分页对象
     */
    @Operation(description = "分页查询我的课表")
    @GetMapping("page")
    public PageDTO<LearningLessonVO> queryMyLessons(PageQuery query){
        return lessonService.queryMyLessons(query);
    }

    /**
     * 查询正在学习的课程
     * @return LearningLessonVO，该vo包含了课程基本信息和当前小结信息
     */
    @GetMapping("/now")
    @Operation(description = "查询正在学习的课程")
    public LearningLessonVO queryMyCurrentLesson() {
        return lessonService.queryMyCurrentLesson();
    }


    /**
     * 校验当前用户是否可以学习当前课程
     * @param courseId 课程 id
     * @return lessonId，如果是报名了则返回lessonId，否则返回空
     */
    @Operation(description = "校验当前用户是否可以学习当前课程")
    @GetMapping("/{courseId}/valid")
    public Long isLessonValid(@PathVariable Long courseId){
        return lessonService.isLessonValid(courseId);
    }

    /**
     * 用户手动删除&退款自动删除课程
     * @param courseId 课程 id
     */
    @Operation(description = "用户手动删除当前课程")
    @DeleteMapping("/{courseId}")
    public void deleteCourseFromLesson(@PathVariable Long courseId){
        Long user = UserContext.getUser();
        lessonService.deleteCourseFromLesson(user, courseId);
    }

    @Operation(description = "用户是否拥有该课程并返回学习进度")
    @GetMapping("/{courseId}")
    public LessonStatusVO queryLessonByCourseId(@PathVariable @Parameter(name = "课程 id", example = "1") Long courseId){
        return lessonService.queryLessonByCourseId(courseId);
    }

    /**
     * 统计课程学习人数
     * @param courseId 课程 id
     * @return 学习人数
     */
    @Operation(description = "查询该课程的报名人数")
    @GetMapping("/lessons/{courseId}/count")
    Integer countLearningLessonByCourse(@PathVariable @Parameter(name = "课程 id", example = "1") Long courseId){
        return Math.toIntExact(lessonService.countLearningLessonByCourse(courseId));
    }

    @Operation(description = "创建学习计划")
    @PostMapping("/plans")
    public void createLearningPlans(@RequestBody @Validated LearningPlanDTO planDTO){
        lessonService.createLearningPlan(planDTO.getCourseId(), planDTO.getFreq());
    }

    @Operation(description = "查询我的学习计划")
    @GetMapping("/plans")
    public LearningPlanPageVO queryMyPlans(PageQuery query){
        return lessonService.queryMyPlans(query);
    }
}
