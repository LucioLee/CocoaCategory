//
//  UIImage+LCExtension.m
//  LeCam
//
//  Created by 李新新 on 2017/2/15.
//
//

#import "UIImage+LucioCategory.h"
#import <objc/runtime.h>
@implementation UIImage (LCExtension)

- (UIColor *)lc_colorAtPoint:(CGPoint)point {
    
    if (self.CGImage == NULL) { return nil; }
    
    size_t pixelsWidth = CGImageGetWidth(self.CGImage);
    size_t pixelsHeight = CGImageGetHeight(self.CGImage);
    
    CGRect drawRect = CGRectMake(0, 0, pixelsWidth, pixelsHeight);
    
    if(!CGRectContainsPoint(drawRect, point)) {
        return nil;
    }
    // 申请地址空间
    size_t bitPerPixel = 4;
    size_t bytesPerRow = pixelsWidth * bitPerPixel;
    size_t bitsPerComponent = 8;
    void *bitmapData = malloc(bytesPerRow * pixelsHeight);
    if (bitmapData == NULL) { return nil; }
    // 创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL) {
        free(bitmapData);
        return nil;
    }
    // 生成位图上下文
    CGContextRef context = CGBitmapContextCreate(bitmapData,
                                                 pixelsWidth,
                                                 pixelsHeight,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast);
    if (context == NULL) {
        free(bitmapData);
        CGColorSpaceRelease(colorSpace);
        return nil;
    }
    // 将图片绘制到位图上下文
    CGContextDrawImage(context, drawRect, self.CGImage);
    
    // 获取位图数据指针
    UInt8 *data = (UInt8 *)CGBitmapContextGetData(context);
    if (data == NULL) {
        free(bitmapData);
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        return nil;
    }
    // 获取指定位置的颜色值信息
    int offset = 4 * ((pixelsWidth * round(point.y)) + round(point.x));
    CGFloat r = data[offset + 0] / 255.0f;
    CGFloat g = data[offset + 1] / 255.0f;
    CGFloat b = data[offset + 2] / 255.0f;
    CGFloat a = data[offset + 3] / 255.0f;
    
    // 生成颜色
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:a];
    
    // 释放内存
    free(bitmapData);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    return color;
}

@end
