package com.tianji.learning.controller;

import com.tianji.common.domain.dto.PageDTO;
import com.tianji.learning.domain.query.QuestionAdminPageQuery;
import com.tianji.learning.domain.query.ReplyPageQuery;
import com.tianji.learning.domain.vo.QuestionAdminVO;
import com.tianji.learning.domain.vo.ReplyVO;
import com.tianji.learning.service.IInteractionQuestionService;
import com.tianji.learning.service.IInteractionReplyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin")
@Tag(name = "管理端相关接口")
@RequiredArgsConstructor
public class InteractionQuestionAdminController {

    private final IInteractionReplyService replyService;

    private final IInteractionQuestionService questionService;

    @Operation(description = "分页查询问题-管理端")
    @GetMapping("/questions/page")
    public PageDTO<QuestionAdminVO> queryQuestionPageAdmin(QuestionAdminPageQuery query){
        return questionService.queryQuestionPageAdmin(query);
    }

    @Operation(description = "隐藏或显示问题-管理端")
    @PutMapping("/questions/{id}/hidden/{hidden}")
    public void hiddenQuestionAdmin(@PathVariable Long id, @PathVariable Boolean hidden){
        questionService.hiddenQuestionAdmin(id, hidden);
    }

    @Operation(description = "查询问题详情-管理端")
    @GetMapping("/questions/{id}")
    public QuestionAdminVO queryQuestionByIdAdmin(@PathVariable @Parameter(name = "问题 id", example = "1") Long id){
        return questionService.queryQuestionByIdAdmin(id);
    }

    @Operation(description = "分页查询回答和评论-管理端")
    @GetMapping("/replies/page")
    public PageDTO<ReplyVO> queryReplyOrAnswerPageAdmin(ReplyPageQuery query){
        return replyService.queryReplyOrAnswerPageAdmin(query);
    }

    @Operation(description = "隐藏或显示回答和评论-管理端")
    @PutMapping("/replies/{id}/hidden/{hidden}")
    public void hiddenReplyAdmin(@PathVariable Long id, @PathVariable Boolean hidden){
        replyService.hiddenReplyAdmin(id, hidden);
    }

    @Operation(description = "查询问题详情-管理端")
    @GetMapping("/replies/{id}")
    public ReplyVO queryReplyById(@PathVariable @Parameter(name = "问题 id", example = "1") Long id){
        return replyService.queryReplyById(id);
    }

}