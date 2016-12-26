//
//  NSDictionary+LucioCategory.h
//  CocoaCategory-OC
//
//  Created by 李新新 on 2016/12/21.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (LucioCategory)

- (nullable NSString *)lc_JSONString;
- (nullable NSString *)lc_prettyJSONString;
+ (nullable NSDictionary *)lc_dictionaryWithPlistData:(NSData *)aPlistData;
+ (nullable NSDictionary *)lc_dictionaryWithPlistString:(NSString *)aPlistString;
- (nullable NSData *)lc_plistData;
- (nullable NSString *)lc_plistString;
- (BOOL)lc_isContainObjectForKey:(id)key;

@end

@interface NSMutableDictionary (LucioCategory)

+ (nullable NSMutableDictionary *)lc_dictionaryWithPlistData:(NSData *)aPlistData;
+ (nullable NSMutableDictionary *)lc_dictionaryWithPlistString:(NSString *)aPlistString;

@end

NS_ASSUME_NONNULL_END
