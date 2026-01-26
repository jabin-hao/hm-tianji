package com.tianji.promotion.utils;

import com.tianji.promotion.enums.MyLockType;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.stereotype.Component;

import java.util.EnumMap;
import java.util.Map;
import java.util.function.Function;

import static com.tianji.promotion.enums.MyLockType.*;


@Component
@RequiredArgsConstructor
public class MyLockFactory {

    private final RedissonClient redissonClient;
    private Map<MyLockType, Function<String, RLock>> lockHandlers; //枚举 MAP 比普通 hashmap 效率更高

    // 初始化 lockHandlers 的逻辑移到 @PostConstruct 方法中
    @PostConstruct
    private void init() {
        this.lockHandlers = new EnumMap<>(MyLockType.class);
        this.lockHandlers.put(RE_ENTRANT_LOCK, redissonClient::getLock);
        this.lockHandlers.put(FAIR_LOCK, redissonClient::getFairLock);
        this.lockHandlers.put(READ_LOCK, name -> redissonClient.getReadWriteLock(name).readLock());
        this.lockHandlers.put(WRITE_LOCK, name -> redissonClient.getReadWriteLock(name).writeLock());
    }

    public RLock getLock(MyLockType lockType, String name){
        return lockHandlers.get(lockType).apply(name);
    }
}