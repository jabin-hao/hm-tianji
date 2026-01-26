package com.tianji.trade.controller;


import com.tianji.common.domain.dto.PageDTO;
import com.tianji.trade.domain.dto.ApproveFormDTO;
import com.tianji.trade.domain.dto.RefundCancelDTO;
import com.tianji.trade.domain.dto.RefundFormDTO;
import com.tianji.trade.domain.query.RefundApplyPageQuery;
import com.tianji.trade.domain.vo.RefundApplyPageVO;
import com.tianji.trade.domain.vo.RefundApplyVO;
import com.tianji.trade.service.IRefundApplyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;

/**
 * <p>
 * 退款申请 前端控制器
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-29
 */
@Tag(name = "退款相关接口")
@RequiredArgsConstructor
@RestController
@RequestMapping("/refund-apply")
public class RefundApplyController {

    private final IRefundApplyService refundApplyService;

    @Operation(description = "退款申请")
    @PostMapping
    public void applyRefund(@Valid @RequestBody RefundFormDTO refundFormDTO) {
        refundApplyService.applyRefund(refundFormDTO);
    }

    @Operation(description = "审批退款申请")
    @PutMapping("/approval")
    public void approveRefundApply(@Valid @RequestBody ApproveFormDTO approveDTO){
        refundApplyService.approveRefundApply(approveDTO);
    }

    @Operation(description = "取消退款申请")
    @PutMapping("/cancel")
    public void cancelRefundApply(@Valid @RequestBody RefundCancelDTO cancelDTO){
        refundApplyService.cancelRefundApply(cancelDTO);
    }

    @Operation(description = "分页查询退款申请")
    @GetMapping("/page")
    public PageDTO<RefundApplyPageVO> queryRefundApplyByPage(RefundApplyPageQuery pageQuery){
        return refundApplyService.queryRefundApplyByPage(pageQuery);
    }

    @Operation(description = "根据 id查询退款详情")
    @GetMapping("/{id}")
    public RefundApplyVO queryRefundDetailById(@PathVariable @Parameter(description = "退款 id") Long id){
        return refundApplyService.queryRefundDetailById(id);
    }

    @Operation(description = "根据子订单 id查询退款详情")
    @GetMapping("/detail/{id}")
    public RefundApplyVO queryRefundDetailByDetailId(@Parameter(description = "子订单 id") @PathVariable("id") Long detailId){
        return refundApplyService.queryRefundDetailByDetailId(detailId);
    }

    @Operation(description = "查询下一个待审批的退款申请")
    @GetMapping("/next")
    public RefundApplyVO nextRefundApplyToApprove(){
        return refundApplyService.nextRefundApplyToApprove();
    }
}
