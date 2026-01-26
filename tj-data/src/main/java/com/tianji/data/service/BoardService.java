package com.tianji.data.service;


import com.tianji.data.model.dto.BoardDataSetDTO;
import com.tianji.data.model.vo.EchartsVO;

import java.util.List;

public interface BoardService {

    /**
     * 看板数据获取
     */
    EchartsVO boardData(List<Integer> types);

    /**
     * 设置看板数据
     */
    void setBoardData(BoardDataSetDTO boardDataSetDTO);
}