package com.tianji.data.controller;


import com.tianji.data.model.dto.TodayDataDTO;
import com.tianji.data.model.vo.TodayDataVO;
import com.tianji.data.service.TodayDataService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

/**
 * 今日数据
 **/
@RestController
@RequestMapping("/data/today")
@Tag(name = "今日数据相关接口")
public class TodayDataController {

    @Resource
    private TodayDataService todayDataService;

    @GetMapping("")
    @Operation(description = "获取今日数据")
    public TodayDataVO get(){
        return todayDataService.get();
    }

    @PutMapping("set")
    @Operation(description = "设置线上数据")
    public void set(@RequestBody TodayDataDTO todayDataDTO) {
        todayDataService.set(todayDataDTO);
    }
}
