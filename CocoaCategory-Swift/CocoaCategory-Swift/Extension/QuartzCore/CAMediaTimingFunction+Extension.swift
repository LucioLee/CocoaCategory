//
//  QuartzCore+Extension.swift
//  ToolKit
//
//  Created by Lucio on 15/12/29.
//  Copyright © 2015年 Person. All rights reserved.
//

import QuartzCore.CAMediaTimingFunction

public extension CAMediaTimingFunction {
    
    @nonobjc static let linear        = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    @nonobjc  static let easeIn        = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
    @nonobjc  static let `default`       = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
    @nonobjc  static let easeOut       = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    @nonobjc  static let easeInEaseOut = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
}
