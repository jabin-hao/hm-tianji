package com.tianji.pay.sdk.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;

import java.time.LocalDateTime;

@Builder
@Schema(description = "支付结果")
public record PayResultDTO(@Schema(description = "支付结果，1：支付中，2：支付失败，3：支付成功") int status,
                           @Schema(description = "支付失败原因") String msg,
                           @Schema(description = "业务订单号") Long bizOrderId,
                           @Schema(description = "业务订单号") Long payOrderNo,
                           @Schema(description = "支付渠道") String payChannel,
                           @Schema(description = "支付成功时间") LocalDateTime successTime) {

    public static final int PAYING = 1;
    public static final int FAILED = 2;
    public static final int SUCCESS = 3;
    public static final String OK = "ok";

}
