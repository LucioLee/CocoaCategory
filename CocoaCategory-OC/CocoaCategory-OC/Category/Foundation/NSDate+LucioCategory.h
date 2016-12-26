//
//  NSDate+LucioCategory.h
//  CocoaCategory-OC
//
//  Created by 李新新 on 2016/12/21.
//
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LucioCategory)

@property (nonatomic, readonly) NSInteger lc_year;
@property (nonatomic, readonly) NSInteger lc_month;
@property (nonatomic, readonly) NSInteger lc_day;
@property (nonatomic, readonly) NSInteger lc_hour;
@property (nonatomic, readonly) NSInteger lc_minute;
@property (nonatomic, readonly) NSInteger lc_second;
@property (nonatomic, readonly) NSInteger lc_nanosecond;
@property (nonatomic, readonly) NSInteger lc_weekday;
@property (nonatomic, readonly) NSInteger lc_weekdayOrdinal;
@property (nonatomic, readonly) NSInteger lc_weekOfMonth;
@property (nonatomic, readonly) NSInteger lc_weekOfYear;
@property (nonatomic, readonly) NSInteger lc_yearForWeekOfYear;
@property (nonatomic, readonly) NSInteger lc_quarter;
@property (nonatomic, readonly) BOOL lc_isLeapMonth;
@property (nonatomic, readonly) BOOL lc_isLeapYear;
@property (nonatomic, readonly) BOOL lc_isToday;
@property (nonatomic, readonly) BOOL lc_isYesterday;

- (nullable NSDate *)lc_dateByAddingYears:(NSInteger)years;
- (nullable NSDate *)lc_dateByAddingMonths:(NSInteger)months;
- (nullable NSDate *)lc_dateByAddingWeeks:(NSInteger)weeks;
- (nullable NSDate *)lc_dateByAddingDays:(NSInteger)days;
- (nullable NSDate *)lc_dateByAddingHours:(NSInteger)hours;
- (nullable NSDate *)lc_dateByAddingMinutes:(NSInteger)minutes;
- (nullable NSDate *)lc_dateByAddingSeconds:(NSInteger)seconds;

- (nullable NSString *)lc_stringWithFormat:(NSString *)format;
- (nullable NSString *)lc_stringWithFormat:(NSString *)format
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale;
- (nullable NSString *)lc_stringWithISOFormat;
+ (nullable NSDate *)lc_dateWithString:(NSString *)dateString format:(NSString *)format;
+ (nullable NSDate *)lc_dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(nullable NSTimeZone *)timeZone
                             locale:(nullable NSLocale *)locale;
+ (nullable NSDate *)lc_dateWithISOFormatString:(NSString *)dateString;


@end

NS_ASSUME_NONNULL_END
