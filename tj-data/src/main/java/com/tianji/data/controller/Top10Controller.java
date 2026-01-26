package com.tianji.data.controller;

import com.tianji.data.model.dto.Top10DataSetDTO;
import com.tianji.data.model.vo.Top10DataVO;
import com.tianji.data.service.Top10Service;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


@RestController
@Tag(name = "工作台top10数据相关接口")
@RequestMapping("/data/top10")
public class Top10Controller {

    @Resource
    private Top10Service top10Service;

    @GetMapping("")
    @Operation(description = "top10数据获取")
    public Top10DataVO getTop10Data() {
        return top10Service.getTop10Data();
    }

    @PutMapping("set")
    @Operation(description = "设置top10数据")
    public void setTop10Data(@RequestBody @Validated Top10DataSetDTO top10DataSetDTO) {
        top10Service.setTop10Data(top10DataSetDTO);
    }

}
