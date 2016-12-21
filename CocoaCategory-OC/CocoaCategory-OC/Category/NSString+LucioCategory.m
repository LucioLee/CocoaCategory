//
//  NSString+LucioCategory.m
//  CocoaCategory-OC
//
//  Created by 李新新 on 2016/12/21.
//
//

#import "NSString+LucioCategory.h"

@implementation NSString (LucioCategory)

- (NSString *)lc_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (BOOL)lc_isEmpty {
    return [self isEqualToString:@""];
}
- (BOOL)lc_isBeginWithString:(NSString *)aString {
    return [self hasPrefix:aString];
}
- (BOOL)lc_isEndWithString:(NSString *)aString {
    return [self hasSuffix:aString];
}
- (NSString *)lc_subStringFromIndex:(NSInteger)beginIndex toIndex:(NSInteger)endIndex {
    NSRange range;
    range.location = beginIndex;
    range.length = endIndex - beginIndex;
    return [self substringWithRange:range];
}

@end
