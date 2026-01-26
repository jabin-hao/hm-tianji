package com.tianji.media.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.tianji.common.exceptions.BadRequestException;
import lombok.Getter;

import static com.tianji.media.enums.FileErrorInfo.Msg.INVALID_FILE_STATUS;


@Getter
public enum FileStatus {
    UPLOADING(1, "上传中"),
    UPLOADED(2, "已上传"),
    PROCESSED(3, "已处理"),
    ;
    @EnumValue
    private final int value;
    private final String desc;

    FileStatus(int value, String desc) {
        this.value = value;
        this.desc = desc;
    }

    public static FileStatus of(int value) {
        return switch (value) {
            case 1 -> UPLOADING;
            case 2 -> UPLOADED;
            case 3 -> PROCESSED;
            default -> throw new BadRequestException(INVALID_FILE_STATUS);
        };
    }
}
