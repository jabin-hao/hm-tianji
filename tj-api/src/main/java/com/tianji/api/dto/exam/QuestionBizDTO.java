package com.tianji.api.dto.exam;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Schema(description = "题目与业务关联信息")
@Accessors(chain = true)
@AllArgsConstructor(staticName = "of")
@NoArgsConstructor
public class QuestionBizDTO{

    @Schema(name = "业务 id", description = "要关联问题的某业务id，例如小节id")
    private Long bizId;

    @Schema(name = "题目 id")
    private Long questionId;

}
