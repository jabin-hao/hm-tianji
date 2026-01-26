package com.tianji.message.controller;


import com.tianji.common.domain.dto.PageDTO;
import com.tianji.message.domain.dto.NoticeTemplateDTO;
import com.tianji.message.domain.dto.NoticeTemplateFormDTO;
import com.tianji.message.domain.query.NoticeTemplatePageQuery;
import com.tianji.message.service.INoticeTemplateService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 通知模板 前端控制器
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-19
 */
@RestController
@RequestMapping("/notice-templates")
@Tag(name = "通知模板管理接口")
@RequiredArgsConstructor
public class NoticeTemplateController {

    private final INoticeTemplateService noticeTemplateService;

    @PostMapping
    @Operation(description = "新增通知模板")
    public Long saveNoticeTemplate(@RequestBody NoticeTemplateFormDTO noticeTemplateFormDTO){
        return noticeTemplateService.saveNoticeTemplate(noticeTemplateFormDTO);
    }

    @PutMapping("/{id}")
    @Operation(description = "更新通知模板")
    public void updateNoticeTemplate(
            @RequestBody NoticeTemplateFormDTO noticeTemplateFormDTO,
            @PathVariable @Parameter(name = "模板 id", example = "1") Long id){
        noticeTemplateFormDTO.setId(id);
        noticeTemplateService.updateNoticeTemplate(noticeTemplateFormDTO);
    }

    @GetMapping
    @Operation(description = "分页查询通知模板")
    public PageDTO<NoticeTemplateDTO> queryNoticeTemplates(NoticeTemplatePageQuery pageQuery){
        return noticeTemplateService.queryNoticeTemplates(pageQuery);
    }

    @GetMapping("/{id}")
    @Operation(description = "根据 id查询模板")
    public NoticeTemplateDTO queryNoticeTemplate(@PathVariable @Parameter(name = "模板 id", example = "1") Long id){
        return noticeTemplateService.queryNoticeTemplate(id);
    }
}
