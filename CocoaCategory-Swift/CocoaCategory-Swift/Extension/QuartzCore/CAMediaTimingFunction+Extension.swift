//
//  QuartzCore+Extension.swift
//  ToolKit
//
//  Created by Lucio on 15/12/29.
//  Copyright © 2015年 Person. All rights reserved.
//

import QuartzCore.CAMediaTimingFunction

public extension CAMediaTimingFunction {
    
    @nonobjc public static let Linear        = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    @nonobjc public static let EaseIn        = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
    @nonobjc public static let Default       = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
    @nonobjc public static let EaseOut       = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    @nonobjc public static let EaseInEaseOut = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
}
