package com.tianji.remark.controller;


import com.tianji.remark.domain.dto.LikeRecordFormDTO;
import com.tianji.remark.service.ILikedRecordService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

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
@RequiredArgsConstructor
public class LikedRecordController {

    private final ILikedRecordService likedRecordService;

    @Operation(description = "点赞或者取消赞")
    @PostMapping()
    public void addLikeRecord(@RequestBody @Validated LikeRecordFormDTO dto){
        likedRecordService.addLikeRecord(dto);
    }

    @Operation(description = "获取用户点赞信息")
    @GetMapping("list")
    public Set<Long> getLikedStatusByBizList(@RequestParam("bizIds") List<Long> ids){
        return likedRecordService.getLikedStatusByBizList(ids);
    }
}
