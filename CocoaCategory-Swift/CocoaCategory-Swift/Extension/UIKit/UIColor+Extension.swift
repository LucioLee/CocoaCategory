//
//  UIColor+Extension.swift
//  LucioExtension
//
//  Created by Lucio on 16/3/10.
//  Copyright © 2016年 Person. All rights reserved.
//

import UIKit.UIColor

 public extension UIColor {
    
     class var pink: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 192.0 / 255.0, blue: 203.0 / 255.0, alpha: 1)
    }
     class var random: UIColor {
        let red   = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: 256.0) / 255.0)
        let green = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: 256.0) / 255.0)
        let blue  = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: 256.0) / 255.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
     class func color(withHexLiteral hexColor: Int) -> UIColor? {
        return UIColor(hexLiteral: hexColor)
    }
     convenience init(hexLiteral: Int) {
        let red   = CGFloat((hexLiteral >> 16) & 0xFF) / 255.0
        let green = CGFloat((hexLiteral >> 08) & 0xFF) / 255.0
        let blue  = CGFloat((hexLiteral >> 00) & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    // MARK: 在该颜色的基础上，混合其他颜色
    func add(color: UIColor, blendModel: CGBlendMode) -> UIColor? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var pixel = Array<UInt8>(repeating: 0, count: 4)
        guard let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue) else {
            return nil
        }
        context.setFillColor(cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        context.setBlendMode(blendModel)
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        return UIColor(red: CGFloat(pixel[0]) / 255.0, green: CGFloat(pixel[1]) / 255.0, blue: CGFloat(pixel[2]) / 255.0, alpha: CGFloat(pixel[3]) / 255.0)
    }
}
