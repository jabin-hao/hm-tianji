package com.tianji.message.controller;


import com.tianji.common.domain.dto.PageDTO;
import com.tianji.message.domain.dto.NoticeTaskDTO;
import com.tianji.message.domain.dto.NoticeTaskFormDTO;
import com.tianji.message.domain.query.NoticeTaskPageQuery;
import com.tianji.message.service.INoticeTaskService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 系统通告的任务表，可以延期或定期发送通告 前端控制器
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-19
 */
@Tag(name = "短信任务管理接口")
@RestController
@RequestMapping("/notice-tasks")
@RequiredArgsConstructor
public class NoticeTaskController {

    private final INoticeTaskService noticeTaskService;

    @PostMapping
    @Operation(description = "新增通知任务")
    public Long saveNoticeTask(@RequestBody NoticeTaskFormDTO noticeTaskFormDTO){
        return noticeTaskService.saveNoticeTask(noticeTaskFormDTO);
    }

    @PutMapping("/{id}")
    @Operation(description = "更新通知任务")
    public void updateNoticeTask(
            @RequestBody NoticeTaskFormDTO noticeTaskFormDTO,
            @PathVariable @Parameter(description = "任务 id", example = "1") Long id){
        noticeTaskFormDTO.setId(id);
        noticeTaskService.updateNoticeTask(noticeTaskFormDTO);
    }

    @GetMapping
    @Operation(description = "分页查询通知任务")
    public PageDTO<NoticeTaskDTO> queryNoticeTasks(NoticeTaskPageQuery pageQuery){
        return noticeTaskService.queryNoticeTasks(pageQuery);
    }

    @GetMapping("/{id}")
    @Operation(description = "根据 id查询任务")
    public NoticeTaskDTO queryNoticeTask(@PathVariable @Parameter(name = "任务 id", example = "1") Long id){
        return noticeTaskService.queryNoticeTask(id);
    }
}
