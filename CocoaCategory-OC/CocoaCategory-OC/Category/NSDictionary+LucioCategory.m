//
//  NSDictionary+LucioCategory.m
//  CocoaCategory-OC
//
//  Created by 李新新 on 2016/12/21.
//
//

#import "NSDictionary+LucioCategory.h"

@implementation NSDictionary (LCJSONSerializing)

- (nullable NSString *)lc_JSONString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
