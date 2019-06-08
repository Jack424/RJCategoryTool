//
//  NSDate+GRJDate.m
//  GRJTolCayFrwk
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 Global Barter. All rights reserved.
//

#import "NSDate+GRJDate.h"
#import "NSString+RJString.h"

static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);
@implementation NSDate (GRJDate)
// Courtesy of Lukasz Margielewski
// Updated via Holger Haenisch
+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - String Properties
- (NSString *) stringWithFormat: (NSString *) format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

- (NSString *) shortString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortDateString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) mediumString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumDateString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) longString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longDateString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}


- (BOOL) isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfMonth != components2.weekOfMonth) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL) isLastMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

- (BOOL) isNextMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}


- (BOOL) isThisYear
{
    // Thanks, baspellis
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

#pragma mark - Adjusting Dates

// Thaks, rsjohnson
- (NSDate *) dateByAddingYears: (NSInteger) dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingYears: (NSInteger) dYears
{
    return [self dateByAddingYears:-dYears];
}

- (NSDate *) dateByAddingMonths: (NSInteger) dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths
{
    return [self dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
    return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
    return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
    return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
    NSDateComponents *dTime = [[NSDate currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - Extremes

- (NSDate *) dateAtStartOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *) dateAtEndOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

#pragma mark - Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark - Decomposing Dates

- (NSInteger) nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger) hour
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger) minute
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger) seconds
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger) day
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger) month
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger) week
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfMonth;
}

- (NSInteger) weekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger) year
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

+ (NSDate *)date:(NSString *)datestr WithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:datestr];
#if ! __has_feature(objc_arc)
    [dateFormatter release];
#endif
    return date;
}

- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

-(NSDate *)dateWithFormatter:(NSString *)formatter {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = formatter;
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}


/******************************************************************************************/

+(NSString *)dateTimeIntervalToDateString:(NSString *)timeInterval{

    return [NSDate dateStringWithTimeInterval:timeInterval DateFormat:@"yyyy-MM-dd"];
}
+(NSString *)dateStyleTwoTimeIntervalToDateString:(NSString *)timeInterval{

    return [NSDate dateStringWithTimeInterval:timeInterval DateFormat:@"yyyy-MM-dd  HH:mm"];
}
+(NSString *)dateStyleThreeTimeIntervalToDateString:(NSString *)timeInterval{

    return [NSDate dateStringWithTimeInterval:timeInterval DateFormat:@"yyyy-MM-dd  HH:mm:ss"];
}
+(NSString *)dateStyleFourTimeIntervalToDateString:(NSString *)timeInterval{

    return [NSDate dateStringWithTimeInterval:timeInterval DateFormat:@"HH:mm:ss"];
}
+(NSString *)dateStyleFiveTimeIntervalToDateString:(NSString *)timeInterval{

    return [NSDate dateStringWithTimeInterval:timeInterval DateFormat:@"MM-dd"];
}
+(NSString *)dateStyleSixTimeIntervalToDateString:(NSString *)timeInterval{
    
    return [NSDate dateStringWithTimeInterval:timeInterval DateFormat:@"HH:mm"];
}
+(NSString *)dateStyleSixTimeIntervalToDateString:(NSString *)timeInterval withFormat:(NSString *)format{
    
    return [NSDate dateStringWithTimeInterval:timeInterval DateFormat:format];
}
+(NSString *)dateStringWithTimeInterval:(NSString *)timeInterval DateFormat:(NSString *)dateFormat{
    if (timeInterval.length<10) {
        return @"";
    }
    if (timeInterval.length==12) {
        timeInterval = [@"0" stringByAppendingString:timeInterval];
    }
    NSMutableString  *mutabletimeInterval=[[NSMutableString alloc]initWithString:timeInterval];
    [mutabletimeInterval insertString:@"." atIndex:10];
    NSTimeInterval timeInter = mutabletimeInterval.doubleValue;
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInter];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;// HH:mm:ss
    return [formatter stringFromDate:confromTimesp];
}

+ (NSString *)dateWeekWithDateString:(NSString *)dateString
{
    if ([NSString rj_stringIsEmpty:dateString]) {
        return @"";
    }
    if (dateString.length<10) {
        return @"";
    }
    if (dateString.length==12) {
        dateString = [@"0" stringByAppendingString:dateString];
    }
    NSMutableString  *mutabletimeInterval=[[NSMutableString alloc]initWithString:dateString];
    [mutabletimeInterval insertString:@"." atIndex:10];
    NSTimeInterval time=[mutabletimeInterval doubleValue];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger _weekday = [weekdayComponents weekday];
    NSString *weekStr;
    if (_weekday == 1) {
        weekStr = @"星期日";
    }else if (_weekday == 2){
        weekStr = @"星期一";
    }else if (_weekday == 3){
        weekStr = @"星期二";
    }else if (_weekday == 4){
        weekStr = @"星期三";
    }else if (_weekday == 5){
        weekStr = @"星期四";
    }else if (_weekday == 6){
        weekStr = @"星期五";
    }else if (_weekday == 7){
        weekStr = @"星期六";
    }
    return weekStr;
}
/******************************************************************************************/
-(void)GRJNSCalendar{
    // 获取日历对象
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSInteger unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
     //获取发布日期组件
    NSDateComponents *cmp = [currentCalendar components:unit fromDate:self];
    // 获取当前日期组件
    NSDateComponents *cmpCurrent = [currentCalendar components:unit fromDate:[NSDate date]];
    if (cmp.year == cmpCurrent.year) {
        NSLog(@"发布日期是今年");
    }
    if ([currentCalendar isDateInToday:self]) {
        NSLog(@"发布日期是今天");
    }
    if ([currentCalendar isDateInYesterday:self]) {
        NSLog(@"发布日期是昨天");
    }
    
    // 2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    // 2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    NSLog(@"%ld",(long)cmps.day);
}

+(NSString *)getCurrentDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss:SSS"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}
// 评论显示时间默认的方法
+ (NSString *)dateStyleCommentTimeIntervalToDateString:(NSString *)timeInterval{
    if (timeInterval.length<10) {
        return @"";
    }
    if (timeInterval.length==12) {
        timeInterval = [@"0" stringByAppendingString:timeInterval];
    }
    NSMutableString  *mutabletimeInterval=[[NSMutableString alloc]initWithString:timeInterval];
    [mutabletimeInterval insertString:@"." atIndex:10];
    NSTimeInterval timeInter = mutabletimeInterval.doubleValue;
    
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:timeInter];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";// HH:mm:ss
    NSString *dateStr = [formatter stringFromDate:createDate];
    NSDateComponents *detalCmp = [createDate detalDateWithNow];
    
    if ([createDate isThisYear]) {
        if ([createDate isToday]) {
            if (detalCmp.hour >= 1) { // 大于1小时
                dateStr = [NSString stringWithFormat:@"%ld小时前",(long)detalCmp.hour];
            } else if (detalCmp.minute > 1) { // 大于1分钟
                dateStr = [NSString stringWithFormat:@"%ld分钟前",(long)detalCmp.minute];
            } else { // 刚刚
                dateStr = @"刚刚";
            }
        } else if ([createDate isYesterday]) { //昨天
            formatter.dateFormat = @"昨天";
            dateStr = [formatter stringFromDate:createDate];
        } else { // 昨天之前
            formatter.dateFormat = @"MM-dd";
            dateStr = [formatter stringFromDate:createDate];
        }
    }
    return dateStr;
}

// 评论显示时间产品经理默认的方法
+ (NSString *)dateStyleCommentProductManagerTimeIntervalToDateString:(NSString *)timeInterval{
    if (timeInterval.length<10) {
        return @"";
    }
    if (timeInterval.length==12) {
        timeInterval = [@"0" stringByAppendingString:timeInterval];
    }
    NSMutableString  *mutabletimeInterval=[[NSMutableString alloc]initWithString:timeInterval];
    [mutabletimeInterval insertString:@"." atIndex:10];
    NSTimeInterval timeInter = mutabletimeInterval.doubleValue;
    
    NSTimeInterval timeNowInter = [NSDate getNowTimeSecondTimestamp].doubleValue;
    NSTimeInterval timeDvalue = timeNowInter-timeInter;
    
    NSString *dateString = [NSDate dateTimeIntervalToDateString:timeInterval];
    
    if (timeNowInter-timeInter<D_MINUTE) {//1分钟内显示为“刚刚”
        dateString = @"刚刚";
    }else if ((timeDvalue>=D_MINUTE)&&(timeDvalue<D_HOUR)){//大于1分钟小于1小时显示为“n分钟前”
        dateString = [NSString stringWithFormat:@"%.0f分钟前",timeDvalue/D_MINUTE];
    }else if ((timeDvalue>=D_HOUR)&&(timeDvalue<D_DAY)){//大于1小时小于一天显示为“n小时前”
        dateString = [NSString stringWithFormat:@"%.0f小时前",timeDvalue/D_HOUR];
    }else if ((timeDvalue>=D_DAY)&&(timeDvalue<D_WEEK)){//大于1天小于7天显示为“n天前”
        dateString = [NSString stringWithFormat:@"%.0f天前",timeDvalue/D_DAY];
    }//其他时间显示年月日
    //NSLog(@"%@",dateString);
    return dateString;
}

- (NSDateComponents *)detalDateWithNow{
    // 判断下发布日期 与 当前日期 小时，分差值
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSInteger unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 获取两个日期的差值，获取发布日期与当前日期差值
    return [currentCalendar components:unit  fromDate:self toDate:[NSDate date] options:NSCalendarWrapComponents];
}



//获取当前时间戳有两种方法(以秒为单位)
+(NSString *)getNowTimeSecondTimestamp{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    return timeSp;
}

//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeMillisecondTimestamp{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"SSS"];
    NSString *sssStr = [formatter stringFromDate:[NSDate date]];
    NSTimeInterval  resultSSS= [[NSDate date] timeIntervalSince1970]*1000+ sssStr.integerValue;
    return [NSString stringWithFormat:@"%.0f",resultSSS];
}
//时间转时间戳
+ (NSInteger)getTimeSteptWithTimeString:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *lastTime = @"2017-01-23 17:22:00";
    NSDate *lastDate = [formatter dateFromString:time];
    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    long firstStamp = [lastDate timeIntervalSince1970];
//    NSLog(@"firstStamp:%ld",firstStamp);
    return firstStamp;
}

-(void)GRJnote{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
}

+(NSDate *)rj_delayWithDate:(NSDate *)date delay:(NSInteger)day{
    NSString *beginDate = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSInteger endIn = beginDate.integerValue + day * 24 * 60 *60;
    NSDate *returnDate = [NSDate dateWithTimeIntervalSince1970:endIn];
    return returnDate;
}
+(NSDate *)rj_delayWithDate:(NSDate *)date delayWithMouth:(NSInteger)mouth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:mouth];//前一个月 -1
    [adcomps setDay:0];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    return newdate;
    
}

+(void)rj_getTheDayEndTimeDateWithDate:(NSDate *)date success:(void(^)(NSDate *nextDayZeroDate,NSDate *theDayLastDate))success{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *today = [dateformat stringFromDate:date];
    
    NSDate *rj_date = [NSDate rj_delayWithDate:[dateformat dateFromString:today] delay:1];
    
    NSTimeInterval beginInt = [rj_date timeIntervalSince1970];
    beginInt -= 1;
    NSDate *rj_endDate = [NSDate dateWithTimeIntervalSince1970:beginInt];
    
    if (success) {
        success(rj_date,rj_endDate);
    }
}
@end
;
