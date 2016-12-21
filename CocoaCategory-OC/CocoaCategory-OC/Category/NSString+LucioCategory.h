//
//  NSString+LucioCategory.h
//  CocoaCategory-OC
//
//  Created by 李新新 on 2016/12/21.
//
//

#import <Foundation/Foundation.h>

@interface NSString (LucioCategory)

- (NSString *)lc_trim;
- (BOOL)lc_isEmpty;
- (BOOL)lc_isBeginWithString:(NSString *)aString;
- (BOOL)lc_isEndWithString:(NSString *)aString;
- (NSString *)lc_subStringFromIndex:(NSInteger)beginIndex
                            toIndex:(NSInteger)endIndex;

@end
