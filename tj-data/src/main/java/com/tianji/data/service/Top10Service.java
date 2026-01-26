package com.tianji.data.service;


import com.tianji.data.model.dto.Top10DataSetDTO;
import com.tianji.data.model.vo.Top10DataVO;

/**
 * @author wusongsong
 * @since 2022/10/10 19:39
 **/
public interface Top10Service {

    /**
     * 获取 top数据
     */
    Top10DataVO getTop10Data();

    /**
     * top 10数据设置
     */
    void setTop10Data(Top10DataSetDTO top10DataSetDTO);
}