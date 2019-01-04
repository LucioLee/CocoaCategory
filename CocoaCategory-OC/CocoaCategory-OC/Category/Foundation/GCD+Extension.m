//
//  NSObject+GCD_Extension.m
//  CocoaCategory-OC
//
//  Created by 李新新 on 2018/11/30.
//

#import "GCD+Extension.h"

dispatch_time_t getDispatchTime(NSDate *date) {
    // 获取时间戳
    NSTimeInterval interval = [date timeIntervalSince1970];
    double second;
    // 将整数部分存放到second,返回小数部分
    double subsecond = modf(interval, &second);
    // 生成timespec结构体
    struct timespec time = { second, subsecond * NSEC_PER_SEC };
    return dispatch_walltime(&time, 0);
}
