//
//  UIImage+Extension.swift
//  Daiqian
//
//  Created by 李新新 on 16/5/10.
//  Copyright © 2016年 Hangzhou Suidifu Network Technology Co., Ltd. All rights reserved.
//

import UIKit


 extension UIImage {
    
     enum RotateOrientation : Int {
        case left // 90 deg CCW
        case right // 90 deg CW
        case down // 180 deg rotation
        case mirrored // as above but image mirrored along other axis. horizontal flip
        case downMirrored // horizontal flip
        case leftMirrored // vertical flip
        case rightMirrored // vertical flip
    }
    
     var height: CGFloat {
        return size.height
    }
     var width: CGFloat {
        return size.width
    }
     func color(at point: CGPoint) -> UIColor? {
        guard let aCGImage = cgImage else {
            return nil
        }
        
        let pixelsWidth = aCGImage.width
        let pixelsHeight = aCGImage.height
        let drawRect = CGRect(x: 0, y: 0, width: pixelsWidth, height: pixelsHeight)
        if (!drawRect.contains(point)) {
            return nil
        }
        //        let bytesPerPixel = 4
        //        let bytesPerRow = pixelsWidth * bytesPerPixel
        let bitsPerComponent = 8
        //        let bitmapDataPointer = malloc(bytesPerRow * pixelsHeight)
        //        defer {
        //            free(bitmapDataPointer)
        //        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // data:如果不为 NULL，那么它应该指向一块大小至少为 bytesPerRow * height 字节的内存；如果为 NULL ，那么系统就会为我们自动分配和释放所需的内存，所以一般指定 NULL 即可;
        // bytesPerRow ：位图的每一行使用的字节数，大小至少为 width * bytes per pixel 字节。有意思的是，当我们指定 0 时，系统不仅会为我们自动计算，而且还会进行 cache line alignment 的优化，更多信息可以查看 https://stackoverflow.com/questions/23790837/what-is-byte-alignment-cache-line-alignment-for-core-animation-why-it-matters 和 https://stackoverflow.com/questions/15935074/why-is-my-images-bytes-per-row-more-than-its-bytes-per-pixel-times-its-width
        guard let context = CGContext(data: nil,
                                      width: pixelsWidth,
                                      height: pixelsHeight,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: 0,
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
    
     class func image(with color:UIColor, and size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    // MARK: 将图片的真实方向调整为手机预览时看到的方向
     func fixOrientation() -> UIImage? {
        
        if imageOrientation == .up { return self }
        
        guard let aCGImage = self.cgImage else {
            return nil
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .left :
            transform = transform.translatedBy(x: CGFloat(aCGImage.height), y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .down :
            transform = transform.translatedBy(x: CGFloat(aCGImage.width), y: CGFloat(aCGImage.height))
            transform = transform.rotated(by: CGFloat.pi)
        case .right:
            transform = transform.translatedBy(x: 0, y: CGFloat(aCGImage.width))
            transform = transform.rotated(by: -CGFloat.pi / 2.0)
        case .upMirrored :
            transform = transform.translatedBy(x: CGFloat(aCGImage.width),y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored:
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            transform = transform.translatedBy(x: CGFloat(aCGImage.width) ,y: CGFloat(-aCGImage.height))
            transform = transform.scaledBy(x: -1, y: 1)
        case .downMirrored:
            transform = transform.translatedBy(x: 0,y: CGFloat(aCGImage.height))
            transform = transform.scaledBy(x: 1, y: -1)
        case .rightMirrored:
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            transform = transform.scaledBy(x: 1, y: -1)
        default:
            break
        }
        let pixelsWidth: Int
        let pixelsHeight: Int
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            pixelsWidth = aCGImage.height
            pixelsHeight = aCGImage.width
        default:
            pixelsWidth = aCGImage.width
            pixelsHeight = aCGImage.height
        }
        guard let colorSpace = aCGImage.colorSpace,
            let context = CGContext(data: nil, width: pixelsWidth, height: pixelsHeight, bitsPerComponent: aCGImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: aCGImage.bitmapInfo.rawValue) else {
                return nil
        }
        context.concatenate(transform)
        context.draw(aCGImage, in: CGRect(x: 0, y: 0, width: aCGImage.width, height: aCGImage.height))
        guard let newCGImage = context.makeImage() else {
            return nil
        }
        let newImage = UIImage(cgImage: newCGImage, scale: scale, orientation: .up)
        return newImage
    }

    // MARK: 旋转图片的方向
     func rotate(with orientation: UIImage.RotateOrientation) -> UIImage? {
        
        guard let aCGImage = self.cgImage else {
            return nil
        }
        
        var transform = CGAffineTransform.identity
        switch orientation {
        case .mirrored :
            transform = transform.translatedBy(x: CGFloat(aCGImage.width),y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .left :
            transform = transform.translatedBy(x: CGFloat(aCGImage.height),y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .leftMirrored :
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            transform = transform.translatedBy(x: CGFloat(aCGImage.width) ,y: CGFloat(-aCGImage.height))
            transform = transform.scaledBy(x: -1, y: 1)
        case .down :
            transform = transform.translatedBy(x: CGFloat(aCGImage.width),y: CGFloat(aCGImage.height))
            transform = transform.rotated(by: CGFloat.pi)
        case .downMirrored :
            transform = transform.translatedBy(x: 0,y: CGFloat(aCGImage.height))
            transform = transform.scaledBy(x: 1, y: -1)
        case .right :
            transform = transform.translatedBy(x: 0,y: CGFloat(aCGImage.width))
            transform = transform.rotated(by: -CGFloat.pi / 2.0)
        case .rightMirrored :
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            transform = transform.scaledBy(x: 1, y: -1)
        }
        
        
        let pixelsWidth: Int
        let pixelsHeight: Int
        
        switch orientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            pixelsWidth = aCGImage.height
            pixelsHeight = aCGImage.width
        default:
            pixelsWidth = aCGImage.width
            pixelsHeight = aCGImage.height
        }
        guard let colorSpace = aCGImage.colorSpace,
            let context = CGContext(data: nil, width: pixelsWidth, height: pixelsHeight, bitsPerComponent: aCGImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: aCGImage.bitmapInfo.rawValue) else {
                return nil
        }
        context.concatenate(transform)
        context.draw(aCGImage, in: CGRect(x: 0, y: 0, width: aCGImage.width, height: aCGImage.height))
        guard let newCGImage = context.makeImage() else {
            return nil
        }
        let newImage = UIImage(cgImage: newCGImage, scale: scale, orientation: imageOrientation)
        return newImage
    }
    
    var hasAlpha: Bool {
        guard let alphaInfo = cgImage?.alphaInfo else {
            return false
        }
        if alphaInfo == .premultipliedLast || alphaInfo == .premultipliedFirst || alphaInfo == .first || alphaInfo == .last {
            return true
        } else {
            return false
        }
    }
     func byAppendingAlpha(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let cgImage = self.cgImage, let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -self.size.height)
        context.setBlendMode(CGBlendMode.multiply)
        context.setAlpha(alpha)
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
     func withTintColor(_ tintColor: UIColor, blendMode: CGBlendMode) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        tintColor.setFill()
        let bounds = CGRect(origin: CGPoint.zero, size: self.size)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: blendMode, alpha: 1.0)
        if blendMode != CGBlendMode.destinationIn {
            self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        }
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
}
