package com.tianji.media.controller;


import com.tianji.common.domain.dto.PageDTO;
import com.tianji.media.domain.dto.MediaDTO;
import com.tianji.media.domain.dto.MediaUploadResultDTO;
import com.tianji.media.domain.query.MediaQuery;
import com.tianji.media.domain.vo.MediaVO;
import com.tianji.media.domain.vo.VideoPlayVO;
import com.tianji.media.service.IMediaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 媒资表，主要是视频文件 前端控制器
 * </p>
 *
 * @author 虎哥
 * @since 2022-06-30
 */
@RestController
@RequestMapping("/medias")
@Tag(name = "媒资管理相关接口")
@RequiredArgsConstructor
public class MediaController {

    private final IMediaService mediaService;

    @Operation(description = "分页搜索已上传媒资信息")
    @GetMapping
    public PageDTO<MediaVO> queryMediaPage(MediaQuery query){
        return mediaService.queryMediaPage(query);
    }

    @Operation(description = "上传视频后保存媒资信息")
    @PostMapping
    public MediaDTO saveMedia(@RequestBody MediaUploadResultDTO result) {
        return mediaService.save(result);
    }

    @Operation(description = "获取上传视频的授权签名")
    @GetMapping("/signature/upload")
    public String getUploadSignature(){
        return mediaService.getUploadSignature();
    }

    @Operation(description = "获取播放视频的授权签名")
    @GetMapping("/signature/play")
    public VideoPlayVO getPlaySignature(
            @Parameter(description = "小节 id", example = "1", required = true) @RequestParam("sectionId") Long sectionId){
        return mediaService.getPlaySignatureBySectionId(sectionId);
    }

    @Operation(description = "管理端获取预览视频的授权签名")
    @GetMapping("/signature/preview")
    public VideoPlayVO getPreviewSignature(
            @Parameter(description = "媒资 id", example = "1", required = true) @RequestParam("mediaId") Long mediaId){
        return mediaService.getPlaySignatureByMediaId(mediaId);
    }

    @Operation(description = "删除媒资视频")
    @DeleteMapping("{mediaId}")
    public void deleteMedia(
            @PathVariable @Parameter(description = "媒资 id", example = "1", required = true) Long mediaId){
        mediaService.removeById(mediaId);
    }

    @Operation(description = "批量删除媒资视频")
    @DeleteMapping
    public void deleteMedias(
            @Parameter(description = "媒资 id 集合，例如1,2,3", required = true) @RequestParam("ids") List<Long> mediaIds){
        mediaService.removeByIds(mediaIds);
    }
}
