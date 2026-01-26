package com.tianji.learning.controller;


import com.tianji.api.client.remark.RemarkClient;
import com.tianji.common.domain.dto.LikeRecordFormDTO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 点赞记录表 前端控制器
 * </p>
 *
 * @author fenny
 * @since 2023-11-26
 */
@Tag(name = "点赞相关接口")
@RestController
@RequestMapping("/likes")
public class LikedRecordController {

    @Resource
    private RemarkClient remarkClient;

    @Operation(description = "点赞或者取消赞")
    @PostMapping()
    public void addLikeRecord(@RequestBody @Validated LikeRecordFormDTO dto){
        remarkClient.addLikeRecord(dto);
    }
}
