//
//  NSArray+LucioCategory.h
//  CocoaCategory-OC
//
//  Created by 李新新 on 2016/12/21.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (LucioCategory)

- (nullable NSString *)lc_JSONString;
- (nullable NSString *)lc_prettyJSONString;
+ (nullable NSArray *)lc_arrayWithPlistData:(NSData *)aPlistData;
+ (nullable NSArray *)lc_arrayWithPlistString:(NSString *)aPlistString;
- (nullable NSData *)lc_plistData;
- (nullable NSString *)lc_plistString;
- (id)lc_objectOrNilAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (LucioCategory)

+ (nullable NSMutableArray *)lc_arrayWithPlistData:(NSData *)aPlistData;
+ (nullable NSMutableArray *)lc_arrayWithPlistString:(NSString *)aPlistString;


@end

NS_ASSUME_NONNULL_END
