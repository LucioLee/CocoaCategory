//
//  NSArray+LucioCategory.m
//  CocoaCategory-OC
//
//  Created by 李新新 on 2016/12/21.
//
//

#import "NSArray+LucioCategory.h"

@implementation NSArray (LucioCategory)

- (nullable NSString *)lc_JSONString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:NULL];
        return [[NSString alloc] initWithData:data
                                     encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (nullable NSString *)lc_prettyJSONString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:NULL];
        return [[NSString alloc] initWithData:data
                                     encoding:NSUTF8StringEncoding];
    }
    return nil;
}
+ (nullable NSArray *)lc_arrayWithPlistData:(NSData *)aPlistData {
    if (!aPlistData) {
        return nil;
    }
    NSArray *array = [NSPropertyListSerialization propertyListWithData:aPlistData
                                                                         options:NSPropertyListImmutable format:NULL
                                                                           error:NULL];
    if ([array isKindOfClass:[NSArray class]]) {
        return array;
    }
    return nil;
}
+ (nullable NSArray *)lc_arrayWithPlistString:(NSString *)aPlistString {
    if (!aPlistString) {
        return nil;
    }
    NSData *data = [aPlistString dataUsingEncoding:NSUTF8StringEncoding];
    return [self lc_arrayWithPlistData:data];
}
- (nullable NSData *)lc_plistData {
    return [NSPropertyListSerialization dataWithPropertyList:self
                                                      format:NSPropertyListBinaryFormat_v1_0
                                                     options:kNilOptions
                                                       error:NULL];
}

- (nullable NSString *)lc_plistString {
    NSData *xmlData = [self lc_plistData];
    if (xmlData) {
        return [[NSString alloc] initWithData:xmlData
                                     encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (id)lc_objectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}

@end

@implementation NSMutableArray (LucioCategory)

+ (nullable NSMutableArray *)lc_arrayWithPlistData:(NSData *)aPlistData {
    if (!aPlistData) {
        return nil;
    }
    NSMutableArray *array = [NSPropertyListSerialization propertyListWithData:aPlistData
                                                               options:NSPropertyListMutableContainersAndLeaves
                                                                format:NULL
                                                                 error:NULL];
    if ([array isKindOfClass:[NSMutableArray class]]) {
        return array;
    }
    return nil;
}
+ (nullable NSMutableArray *)lc_arrayWithPlistString:(NSString *)aPlistString {
    if (!aPlistString) {
        return nil;
    }
    NSData *data = [aPlistString dataUsingEncoding:NSUTF8StringEncoding];
    return [self lc_arrayWithPlistData:data];
}

@end
