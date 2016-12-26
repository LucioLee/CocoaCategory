//
//  NSDictionary+LucioCategory.m
//  CocoaCategory-OC
//
//  Created by 李新新 on 2016/12/21.
//
//

#import "NSDictionary+LucioCategory.h"

@implementation NSDictionary (LucioCategory)

- (NSString *)lc_JSONString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:NULL];
        return [[NSString alloc] initWithData:data
                                     encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (NSString *)lc_prettyJSONString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:NULL];
        return [[NSString alloc] initWithData:data
                                     encoding:NSUTF8StringEncoding];
    }
    return nil;
}
+ (NSDictionary *)lc_dictionaryWithPlistData:(NSData *)aPlistData {
    if (!aPlistData) {
        return nil;
    }
    NSDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:aPlistData
                                                                         options:NSPropertyListImmutable format:NULL
                                                                           error:NULL];
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        return dictionary;
    }
    return nil;
}
+ (NSDictionary *)lc_dictionaryWithPlistString:(NSString *)aPlistString {
    if (!aPlistString) {
        return nil;
    }
    NSData *data = [aPlistString dataUsingEncoding:NSUTF8StringEncoding];
    return [self lc_dictionaryWithPlistData:data];
}
- (NSData *)lc_plistData {
    return [NSPropertyListSerialization dataWithPropertyList:self
                                                      format:NSPropertyListBinaryFormat_v1_0
                                                     options:kNilOptions
                                                       error:NULL];
}

- (NSString *)lc_plistString {
    NSData *xmlData = [self lc_plistData];
    if (xmlData) {
        return [[NSString alloc] initWithData:xmlData
                                     encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (BOOL)lc_isContainObjectForKey:(id)key {
    if (!key) return NO;
    return self[key] != nil;
}

@end

@implementation NSMutableDictionary (LucioCategory)

+ (NSMutableDictionary *)lc_dictionaryWithPlistData:(NSData *)aPlistData {
    if (!aPlistData) {
        return nil;
    }
    NSMutableDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:aPlistData
                                                                                options:NSPropertyListMutableContainersAndLeaves
                                                                                 format:NULL
                                                                                  error:NULL];
    if ([dictionary isKindOfClass:[NSMutableDictionary class]]) {
        return dictionary;
    }
    return nil;
}
+ (NSMutableDictionary *)lc_dictionaryWithPlistString:(NSString *)aPlistString {
    if (!aPlistString) {
        return nil;
    }
    NSData *data = [aPlistString dataUsingEncoding:NSUTF8StringEncoding];
    return [self lc_dictionaryWithPlistData:data];
}

@end
