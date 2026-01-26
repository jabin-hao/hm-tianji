package com.tianji.message.controller;


import com.tianji.common.domain.dto.PageDTO;
import com.tianji.message.domain.dto.SmsThirdPlatformDTO;
import com.tianji.message.domain.dto.SmsThirdPlatformFormDTO;
import com.tianji.message.domain.query.SmsThirdPlatformPageQuery;
import com.tianji.message.service.ISmsThirdPlatformService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 第三方云通讯平台 前端控制器
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-19
 */
@Tag(name = "短信平台管理接口")
@RestController
@RequestMapping("/sms-platforms")
@RequiredArgsConstructor
public class SmsThirdPlatformController {

    private final ISmsThirdPlatformService smsThirdPlatformService;

    @PostMapping
    @Operation(description = "新增短信平台信息")
    public Long saveSmsThirdPlatform(@RequestBody SmsThirdPlatformFormDTO smsThirdPlatformDTO){
        return smsThirdPlatformService.saveSmsThirdPlatform(smsThirdPlatformDTO);
    }

    @PutMapping("/{id}")
    @Operation(description = "更新短信平台信息")
    public void updateSmsThirdPlatform(
            @RequestBody SmsThirdPlatformFormDTO smsThirdPlatformDTO,
            @PathVariable @Parameter(name = "短信平台 id", example = "1") Long id){
        smsThirdPlatformDTO.setId(id);
        smsThirdPlatformService.updateSmsThirdPlatform(smsThirdPlatformDTO);
    }

    @GetMapping
    @Operation(description = "分页查询短信平台信息")
    public PageDTO<SmsThirdPlatformDTO> querySmsThirdPlatforms(SmsThirdPlatformPageQuery pageQuery){
        return smsThirdPlatformService.querySmsThirdPlatforms(pageQuery);
    }

    @GetMapping("/{id}")
    @Operation(description = "根据 id查询短信平台信息")
    public SmsThirdPlatformDTO querySmsThirdPlatform(
            @PathVariable @Parameter(name = "短信平台 id", example = "1") Long id){
        return smsThirdPlatformService.querySmsThirdPlatform(id);
    }
}
