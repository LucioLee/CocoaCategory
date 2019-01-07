//
//  Dispatch+Extension.swift
//  CocoaCategory-Swift
//
//  Created by 李新新 on 2018/11/30.
//  Copyright © 2018 李新新. All rights reserved.
//

import Foundation

extension DispatchWallTime {
    
    init(date: Date) {
        self.init(timeIntervalSince1970: date.timeIntervalSince1970)
    }
    
    init(timeIntervalSince1970 interval: TimeInterval) {
        // 将整数部分存放到second,返回小数部分
        var second: Double = 0
        let subsecond: Double = modf(interval, &second)
        let nowTimespec: timespec = timespec(tv_sec: __darwin_time_t(second), tv_nsec: Int(subsecond * Double(NSEC_PER_SEC)))
        self.init(timespec: nowTimespec)
    }
}

extension DispatchQueue {
    // This method will dispatch the `block` to self.
    // If `self` is the main queue, and current thread is main thread, the block
    // will be invoked immediately instead of being dispatched.
    func safeAsync(_ block: @escaping ()->()) {
        if self === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async { block() }
        }
    }
}
