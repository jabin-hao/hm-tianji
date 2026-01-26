package com.tianji.learning.controller;


import com.tianji.common.domain.dto.PageDTO;
import com.tianji.learning.domain.dto.ReplyDTO;
import com.tianji.learning.domain.query.ReplyPageQuery;
import com.tianji.learning.domain.vo.ReplyVO;
import com.tianji.learning.service.IInteractionReplyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;

/**
 * <p>
 * 互动问题的回答或评论 前端控制器
 * </p>
 *
 * @author fenny
 * @since 2023-11-24
 */
@RequiredArgsConstructor
@Tag(name = "用户端回答或评论相关接口")
@RestController
@RequestMapping("/replies")
public class InteractionReplyController {

    private final IInteractionReplyService replyService;

    @Operation(description = "新增回答或评论-用户端")
    @PostMapping
    public void addReplyOrAnswer(@Valid @RequestBody ReplyDTO dto){
        replyService.addReplyOrAnswer(dto);
    }

    @Operation(description = "分页查询回答和评论-用户端")
    @GetMapping("page")
    public PageDTO<ReplyVO> queryReplyOrAnswerPage(ReplyPageQuery query){
        return replyService.queryReplyOrAnswerPage(query, Boolean.FALSE);
    }
}
