package com.tianji.message.controller;


import com.tianji.common.domain.dto.PageDTO;
import com.tianji.message.domain.dto.MessageTemplateDTO;
import com.tianji.message.domain.dto.MessageTemplateFormDTO;
import com.tianji.message.domain.query.MessageTemplatePageQuery;
import com.tianji.message.service.IMessageTemplateService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 第三方短信平台模板信息管理 前端控制器
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-19
 */
@Tag(name = "短信模板管理接口")
@RestController
@RequestMapping("/message-templates")
@RequiredArgsConstructor
public class MessageTemplateController {

    private final IMessageTemplateService messageTemplateService;

    @PostMapping
    @Operation(description = "新增短信模板")
    public Long saveMessageTemplate(@RequestBody MessageTemplateFormDTO messageTemplateDTO){
        return messageTemplateService.saveMessageTemplate(messageTemplateDTO);
    }

    @PutMapping("/{id}")
    @Operation(description = "更新短信模板")
    public void updateMessageTemplate(
            @RequestBody MessageTemplateFormDTO messageTemplateDTO,
            @PathVariable @Parameter(description = "短信模板 id", example = "1") Long id){
        messageTemplateDTO.setId(id);
        messageTemplateService.updateMessageTemplate(messageTemplateDTO);
    }

    @GetMapping
    @Operation(description = "分页查询短信模板")
    public PageDTO<MessageTemplateDTO> queryMessageTemplates(MessageTemplatePageQuery pageQuery){
        return messageTemplateService.queryMessageTemplates(pageQuery);
    }

    @GetMapping("/{id}")
    @Operation(description = "根据 id查询短信模板")
    public MessageTemplateDTO queryMessageTemplate(@PathVariable @Parameter(name = "模板 id", example = "1") Long id){
        return messageTemplateService.queryMessageTemplate(id);
    }
}
