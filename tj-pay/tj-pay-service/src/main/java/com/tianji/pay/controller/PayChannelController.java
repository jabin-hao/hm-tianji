package com.tianji.pay.controller;


import com.tianji.common.utils.BeanUtils;
import com.tianji.pay.sdk.dto.PayChannelDTO;
import com.tianji.pay.service.IPayChannelService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;

/**
 * <p>
 * 支付渠道 前端控制器
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-26
 */
@Tag(name = "支付渠道")
@RestController
@RequiredArgsConstructor
@RequestMapping("/pay-channels")
public class PayChannelController {

    private final IPayChannelService channelService;

    @Operation(description = "查询支付渠道列表")
    @GetMapping("/list")
    public List<PayChannelDTO> listAllPayChannels(){
        return BeanUtils.copyList(channelService.list(), PayChannelDTO.class);
    }

    @Operation(description = "添加支付渠道")
    @PostMapping
    public Long addPayChannel(@Valid @RequestBody PayChannelDTO channelDTO){
        return channelService.addPayChannel(channelDTO);
    }

    @Operation(description = "修改支付渠道")
    @PutMapping("/{id}")
    public void updatePayChannel(
            @PathVariable @Parameter(description = "支付渠道 id") Long id,
            @RequestBody PayChannelDTO channelDTO){
        channelDTO.setId(id);
        channelService.updatePayChannel(channelDTO);
    }
}
