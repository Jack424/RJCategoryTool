//
//  NSDate+GRJDate.h
//  GRJTolCayFrwk
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 Global Barter. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926


@interface NSDate (GRJDate)




+ (NSCalendar *) currentCalendar; // avoid bottlenecks

// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;
+ (NSDate *)date:(NSString *)datestr WithFormat:(NSString *)format;

// Short string utilities
- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;
- (NSString *) stringWithFormat: (NSString *) format;
@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;

- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;

- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;

- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isNextMonth;
- (BOOL) isLastMonth;

- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;

- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *) dateByAddingYears: (NSInteger) dYears;
- (NSDate *) dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;

// Date extremes
- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

- (NSDate *)dateWithYMD;
- (NSDate *)dateWithFormatter:(NSString *)formatter;


/******************************************************************************************/
+(NSString *)dateWeekWithDateString:(NSString *)dateString;//根据时间戳判断星期几
+(NSString *)dateStringWithTimeInterval:(NSString *)timeInterval DateFormat:(NSString *)dateFormat;
+(NSString *)dateTimeIntervalToDateString:(NSString *)timeInterval; //yyyy-MM-dd

+(NSString *)dateStyleTwoTimeIntervalToDateString:(NSString *)timeInterval;//yyyy-MM-dd  HH:mm

+(NSString *)dateStyleThreeTimeIntervalToDateString:(NSString *)timeInterval;//yyyy-MM-dd  HH:mm:ss

+(NSString *)dateStyleFourTimeIntervalToDateString:(NSString *)timeInterval;//HH:mm:ss

+(NSString *)dateStyleFiveTimeIntervalToDateString:(NSString *)timeInterval;//MM-dd

+(NSString *)dateStyleSixTimeIntervalToDateString:(NSString *)timeInterval;//HH:mm
/******************************************************************************************/
-(void)GRJNSCalendar;

// 评论显示时间默认的方法
+ (NSString *)dateStyleCommentTimeIntervalToDateString:(NSString *)timeInterval;//评论时间显示
// 评论显示时间产品经理默认的方法
+ (NSString *)dateStyleCommentProductManagerTimeIntervalToDateString:(NSString *)timeInterval;
+ (NSString *)getCurrentDate;


+(NSString *)getNowTimeSecondTimestamp;//秒时间戳
+(NSString *)getNowTimeMillisecondTimestamp;//毫秒时间戳


/**
 从一个date延长几天后的date

 @param date 原始date
 @param day 延长天数
 @return 延长后的date
 */
+(NSDate *)rj_delayWithDate:(NSDate *)date delay:(NSInteger)day;
+(NSDate *)rj_delayWithDate:(NSDate *)date delayWithMouth:(NSInteger)mouth;
/**
 时间戳转时间

 @param timeInterval 时间戳
 @param format 格式(yyyy-MM-dd HH:mm:ss)
 @return 转换的时间
  */
+(NSString *)dateStyleSixTimeIntervalToDateString:(NSString *)timeInterval withFormat:(NSString *)format;

//时间转时间戳
+ (NSInteger)getTimeSteptWithTimeString:(NSString *)time;

+(void)rj_getTheDayEndTimeDateWithDate:(NSDate *)date success:(void(^)(NSDate *nextDayZeroDate,NSDate *theDayLastDate))success;
@end
