package com.tianji.course.controller;

import com.tianji.course.domain.vo.CataSimpleInfoVO;
import com.tianji.course.service.ICourseCatalogueService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 目录课程相关接口
 **/
@Tag(name = "章节目录相关接口")
@RestController
@RequestMapping("catalogues")
public class CatalogueController {

    @Resource
    private ICourseCatalogueService courseCatalogueService;

    @GetMapping("batchQuery")
    @Operation(description = "根据章节目录批量查询基础信息")
    public List<CataSimpleInfoVO> batchQuery(@RequestParam("ids") List<Long> ids) {
        return courseCatalogueService.getManyCataSimpleInfo(ids);
    }

    @GetMapping("querySectionInfoById/{id}")
    @Operation(description = "获取小节信息")
    public CataSimpleInfoVO querySectionInfoById(@PathVariable Long id) {
        return courseCatalogueService.querySectionInfoById(id);
    }
}
