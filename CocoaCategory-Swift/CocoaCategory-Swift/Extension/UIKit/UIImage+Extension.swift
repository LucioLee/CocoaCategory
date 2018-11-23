//
//  UIImage+Extension.swift
//  Daiqian
//
//  Created by 李新新 on 16/5/10.
//  Copyright © 2016年 Hangzhou Suidifu Network Technology Co., Ltd. All rights reserved.
//

import UIKit

public enum UIImageRotateOrientation : Int {
    case left // 90 deg CCW
    case right // 90 deg CW
    case down // 180 deg rotation
    case mirrored // as above but image mirrored along other axis. horizontal flip
    case downMirrored // horizontal flip
    case leftMirrored // vertical flip
    case rightMirrored // vertical flip
}

public extension UIImage {
    
    public var height: CGFloat {
        return size.height
    }
    public var width: CGFloat {
        return size.width
    }
    public func color(at point: CGPoint) -> UIColor? {
        guard let aCGImage = cgImage else {
            return nil
        }
        
        let pixelsWidth = aCGImage.width
        let pixelsHeight = aCGImage.height
        let drawRect = CGRect(x: 0, y: 0, width: pixelsWidth, height: pixelsHeight)
        if (!drawRect.contains(point)) {
            return nil
        }
        let bytesPerPixel = 4
        let bytesPerRow = pixelsWidth * bytesPerPixel
        let bitsPerComponent = 8
        let bitmapDataPointer = malloc(bytesPerRow * pixelsHeight)
        defer {
            free(bitmapDataPointer)
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let context = CGContext(data: bitmapDataPointer,
                                      width: pixelsWidth,
                                      height: pixelsHeight,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
                                        return nil
        }
        context.draw(aCGImage, in: drawRect)
        guard let imageDataPointer = context.data else {
            return nil
        }
        
        let offset = 4 * (Int(pixelsWidth) * Int(point.y) + Int(point.x))
        let red   = CGFloat(imageDataPointer.load(fromByteOffset: offset + 0, as: UInt8.self)) / 255.0
        let green = CGFloat(imageDataPointer.load(fromByteOffset: offset + 1, as: UInt8.self)) / 255.0
        let blue  = CGFloat(imageDataPointer.load(fromByteOffset: offset + 2, as: UInt8.self)) / 255.0
        let alpha = CGFloat(imageDataPointer.load(fromByteOffset: offset + 3, as: UInt8.self)) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public class func image(with color:UIColor, and size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    public func fixOrientation() -> UIImage {
        
        if imageOrientation == .up { return self }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .left :
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .down :
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .right:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -CGFloat.pi / 2.0)
        case .upMirrored :
            transform = transform.translatedBy(x: size.width,y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored:
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            transform = transform.translatedBy(x: size.height ,y: -size.width)
            transform = transform.scaledBy(x: -1, y: 1)
        case .downMirrored:
            transform = transform.translatedBy(x: 0,y: size.height)
            transform = transform.scaledBy(x: 1, y: -1)
        case .rightMirrored:
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            transform = transform.scaledBy(x: 1, y: -1)
        default:
            break
        }
        let drawSize = [.left, .leftMirrored, .right, .rightMirrored].contains(imageOrientation) ? CGSize(width: size.height, height: size.width) : CGSize(width: size.width, height: size.height)
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage!.bitsPerComponent, bytesPerRow: 0, space: cgImage!.colorSpace!, bitmapInfo: cgImage!.bitmapInfo.rawValue)!
        context.concatenate(transform)
        context.draw(cgImage!, in: CGRect(origin: CGPoint.zero, size:drawSize))
        let cgImg = context.makeImage()!
        let img:UIImage = UIImage(cgImage: cgImg)
        
        return img
    }
    
    public func rotate(with orientation: UIImageRotateOrientation) -> UIImage {
        var transform = CGAffineTransform.identity
        switch orientation {
        case .mirrored :
            transform = transform.translatedBy(x: size.width,y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .left :
            transform = transform.translatedBy(x: size.height,y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .leftMirrored :
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            transform = transform.translatedBy(x: size.width ,y: -size.height)
            transform = transform.scaledBy(x: -1, y: 1)
        case .down :
            transform = transform.translatedBy(x: size.width,y: size.height)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .downMirrored :
            transform = transform.translatedBy(x: 0,y: size.height)
            transform = transform.scaledBy(x: 1, y: -1)
        case .right :
            transform = transform.translatedBy(x: 0,y: size.width)
            transform = transform.rotated(by: -CGFloat.pi / 2.0)
        case .rightMirrored :
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            transform = transform.scaledBy(x: 1, y: -1)
        }
        let drawSize = [.left, .leftMirrored, .right, .rightMirrored].contains(orientation) ? CGSize(width: size.height, height: size.width) : CGSize(width: size.width, height: size.height)
        
        let context = CGContext(data: nil, width: Int(drawSize.width), height: Int(drawSize.height), bitsPerComponent: cgImage!.bitsPerComponent,bytesPerRow: 0, space: cgImage!.colorSpace!, bitmapInfo: cgImage!.bitmapInfo.rawValue)!
        context.concatenate(transform)
        context.draw(cgImage!, in: CGRect(x: 0, y: 0, width:size.width, height: size.height))
        let cgImg = context.makeImage()!
        let img =  UIImage(cgImage: cgImg, scale: scale, orientation: imageOrientation)
        return img
    }
}
