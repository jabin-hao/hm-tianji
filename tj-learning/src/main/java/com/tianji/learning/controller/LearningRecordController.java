package com.tianji.learning.controller;


import com.tianji.api.dto.leanring.LearningLessonDTO;
import com.tianji.learning.domain.dto.LearningRecordFormDTO;
import com.tianji.learning.service.ILearningRecordService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 学习记录表 前端控制器
 * </p>
 *
 * @author fenny
 * @since 2023-11-21
 */
@Tag(name = "学习记录的相关接口")
@RequiredArgsConstructor
@RestController
@RequestMapping("/learning-records")
public class LearningRecordController {

    private final ILearningRecordService recordService;

    @Operation(description = "查询指定课程的学习记录")
    @GetMapping("/course/{courseId}")
    public LearningLessonDTO queryLearningRecordByCourse(
            @PathVariable @Parameter(name = "课程 id", example = "2") Long courseId){
        return recordService.queryLearningRecordByCourse(courseId);
    }

    @Operation(description = "提交学习记录")
    @PostMapping()
    public void addLearningRecord(@RequestBody @Validated LearningRecordFormDTO formDTO){
        recordService.addLearningRecord(formDTO);
    }
}
