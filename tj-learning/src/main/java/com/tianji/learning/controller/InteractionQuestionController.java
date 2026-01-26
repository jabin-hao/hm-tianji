package com.tianji.learning.controller;


import com.tianji.common.domain.dto.PageDTO;
import com.tianji.learning.domain.dto.QuestionFormDTO;
import com.tianji.learning.domain.query.QuestionPageQuery;
import com.tianji.learning.domain.vo.QuestionVO;
import com.tianji.learning.service.IInteractionQuestionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;

/**
 * <p>
 * 互动提问的问题表 前端控制器
 * </p>
 *
 * @author fenny
 * @since 2023-11-24
 */
@RestController
@RequestMapping("/questions")
@RequiredArgsConstructor
@Tag(name = "用户端问题相关接口")
public class InteractionQuestionController {

    private final IInteractionQuestionService questionService;

    @Operation(description = "新增提问")
    @PostMapping
    public void saveQuestion(@Valid @RequestBody QuestionFormDTO questionDTO){
        questionService.saveQuestion(questionDTO);
    }

    @Operation(description = "修改提问")
    @PutMapping("{id}")
    public void updateQuestion(@PathVariable Long id, @RequestBody QuestionFormDTO questionDTO){
        questionService.updateQuestion(id, questionDTO);
    }

    @Operation(description = "删除提问")
    @DeleteMapping("{id}")
    public void deleteQuestion(@PathVariable Long id){
        questionService.deleteQuestion(id);
    }

    @Operation(description = "分页查询问题-用户端")
    @GetMapping("page")
    public PageDTO<QuestionVO> queryQuestionPage(QuestionPageQuery query){
        return questionService.queryQuestionPage(query);
    }

    @Operation(description = "查询问题详情-用户端")
    @GetMapping("{id}")
    public QuestionVO queryQuestionById(@PathVariable @Parameter(name = "问题 id", example = "1") Long id){
        return questionService.queryQuestionById(id);
    }
}