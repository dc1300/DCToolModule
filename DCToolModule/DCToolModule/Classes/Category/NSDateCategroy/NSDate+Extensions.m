//
//  NSDate+Extensions.m
//  PurangFinanceVillage-Bank
//
//  Created by wangyilu on 16/1/27.
//  Copyright © 2016年 ___PURANG___. All rights reserved.
//

#import "NSDate+Extensions.h"

static NSDateFormatter *dateFormatter;

@implementation NSDate (Extensions)

+ (NSDate *)addMonthDate:(NSDate *)now withMonths:(NSInteger)months {
    NSDateComponents *monthBeforeDateComponents = [[NSDateComponents alloc] init];
    monthBeforeDateComponents.month = months;
    NSDate *rsDate = [[NSCalendar currentCalendar]dateByAddingComponents:monthBeforeDateComponents toDate:now options:0];
    return rsDate;
}

+ (NSDate *)addDayDate:(NSDate *)now withDays:(NSInteger)days {
    NSDateComponents *dayBeforeDateComponents = [[NSDateComponents alloc] init];
    dayBeforeDateComponents.day = days;
    NSDate *rsDate = [[NSCalendar currentCalendar]dateByAddingComponents:dayBeforeDateComponents toDate:now options:0];
    return rsDate;
}

+ (NSString *)getCurrentyear {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

+ (NSString *)getCurrentMonth {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

+ (NSString *)getCurrentDateString {
    NSDate *now = [NSDate date];//根据当前系统的时区产生当前的时间，绝对时间，所以同为中午12点，不同的时区，这个时间是不同的。
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone systemTimeZone];//系统所在时区
    df.dateFormat = @"yyyyMMdd";
    NSString *systemTimeZoneStr =  [df stringFromDate:now];
    
    return systemTimeZoneStr;
}

- (NSString *)formatDateString {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone systemTimeZone];//系统所在时区
    df.dateFormat = @"yyyy-MM-dd";
    NSString *systemTimeZoneStr =  [df stringFromDate:self];
    
    return systemTimeZoneStr;
}

+ (NSString *)getYearMonthDayWithNSDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr =  [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSDateFormatter *)defaultFormatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc]init];
    });
    return dateFormatter;
}

+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [NSDate defaultFormatter];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}

+ (NSInteger)cTimestampFromDate:(NSDate *)date
{
    return (long)[date timeIntervalSince1970];
}


+ (NSInteger)cTimestampFromString:(NSString *)timeStr
                          format:(NSString *)format
{
    NSDate *date = [NSDate dateFromString:timeStr format:format];
    return [NSDate cTimestampFromDate:date];
}

+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [NSDate datestrFromDate:date withDateFormat:format];
}

+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format
{
    NSDateFormatter* dateFormat = [NSDate defaultFormatter];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}
+ (NSInteger)datestrFromDate:(NSString *)date endDate:(NSString *)endDate withDateFormat:(NSString *)format
{
    NSDate * oneDate = [self dateFromString:date format:format];
    NSDate * twoDate = [self dateFromString:endDate format:format];
    NSInteger result = [oneDate compare:twoDate];
    return result;
}

- (int)getYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return (int)dateComponent.year;
}

- (int)getMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return (int)dateComponent.month;
}

- (int)getDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return (int)dateComponent.day;
}

- (int)getHours {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return (int)dateComponent.hour;
}

- (int)getMinutes {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return (int)dateComponent.minute;
}

- (int)getSeconds {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return (int)dateComponent.second;
}

@end
