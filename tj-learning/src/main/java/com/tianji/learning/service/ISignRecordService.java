package com.tianji.learning.service;

import com.tianji.learning.domain.vo.SignResultVO;

import java.util.Deque;

public interface ISignRecordService {
    SignResultVO addSignRecords();

    Deque<Integer> querySignRecords();

}