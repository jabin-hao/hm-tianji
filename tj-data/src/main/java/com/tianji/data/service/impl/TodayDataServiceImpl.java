package com.tianji.data.service.impl;

import com.tianji.common.utils.BeanUtils;
import com.tianji.common.utils.JsonUtils;
import com.tianji.data.constants.RedisConstants;
import com.tianji.data.model.dto.TodayDataDTO;
import com.tianji.data.model.po.TodayDataInfo;
import com.tianji.data.model.vo.TodayDataVO;
import com.tianji.data.service.TodayDataService;
import com.tianji.data.utils.DataUtils;
import jakarta.annotation.Resource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

@Service
public class TodayDataServiceImpl implements TodayDataService {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Override
    public TodayDataVO get() {
        // 1.数据redis存储key
        String key = RedisConstants.KEY_TODAY + DataUtils.getVersion(1);
        // 2.获取数据
        Object originData = redisTemplate.opsForValue().get(key);
        // 2.1.数据判空
        if (originData == null) {
            return new TodayDataVO();
        }
        return JsonUtils.toBean(originData.toString(), TodayDataVO.class);
    }

    @Override
    public void set(TodayDataDTO todayDataDTO) {
        // 1.数据redis存储key
        String key = RedisConstants.KEY_TODAY + todayDataDTO.getVersion();
        // 2.数据转化
        TodayDataInfo todayDataInfo = BeanUtils.toBean(todayDataDTO, TodayDataInfo.class);
        // 3.数据存储
        redisTemplate.opsForValue().set(key, JsonUtils.toJsonStr(todayDataInfo));
    }
}
