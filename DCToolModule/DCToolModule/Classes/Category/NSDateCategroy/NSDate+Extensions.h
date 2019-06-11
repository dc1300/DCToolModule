//
//  NSDate+Extensions.h
//  PurangFinanceVillage-Bank
//
//  Created by wangyilu on 16/1/27.
//  Copyright © 2016年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensions)

/**
 计算传入日期相距months的日期
 @param now 传入日期
 @param months 相距的month
 @return 新的日期
 */
+(NSDate*)addMonthDate:(NSDate*)now withMonths:(NSInteger)months;

/**
 计算传入日期相距days的日期

 @param now 传入s日期
 @param days 相距的days
 @return 新的日期
 */
+(NSDate*)addDayDate:(NSDate*) now withDays:(NSInteger) days;

/**
 手机时间的year

 @return 手机时间的year
 */
+(NSString *)getCurrentyear;

/**
 手机时间的month

 @return 手机时间的month
 */
+(NSString *)getCurrentMonth;

/**
 手机时间的当前时间 格式yyyyMMdd

 @return 手机时间的当前时间 格式yyyyMMdd
 */
+(NSString *)getCurrentDateString;

/**
 将手机时间转化为yyyy-MM-dd的格式string

 @return 将时间转化为yyyy-MM-dd的格式string
 */
-(NSString *)formatDateString;

/**
 *  NSDate -> NSString  yyyy-MM-dd
 *
 */
+ (NSString *)getYearMonthDayWithNSDate:(NSDate *)date;

/**
 *  字符串转NSDate
 *
 *  @param format  转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return date
 */
+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format;

/**
 *  NSDate转时间戳
 *
 *  @param date 字符串时间
 *
 *  @return 返回时间戳
 */
+ (NSInteger)cTimestampFromDate:(NSDate *)date;

/**
 *  字符串转时间戳
 *
 *  @param format  转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回时间戳的字符串
 */
+(NSInteger)cTimestampFromString:(NSString *)timeStr
                          format:(NSString *)format;


/**
 *  时间戳转字符串
 *
 *  @param timeStamp 时间戳
 *  @param format    转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format;

/**
 *  NSDate转字符串
 *
 *  @param date   NSDate时间
 *  @param format 转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format;


/**
 比较2个时间的大小
 
 @param date 第一个日期
 @param endDate 第二个日期
 @param format dateStr的格式
 @return 比较的结果
 */
+ (NSInteger)datestrFromDate:(NSString *)date endDate:(NSString *)endDate withDateFormat:(NSString *)format;


/**
 获取date的year

 @return year
 */
-(int)getYear;

/**
 获取date的month

 @return month
 */
-(int)getMonth;

/**
 获取date的day

 @return day
 */
-(int)getDay;

/**
 获取date的hours

 @return hours
 */
-(int)getHours;

/**
 获取date的minute

 @return minute
 */
-(int)getMinutes;

/**
 获取date的sceond

 @return sceond
 */
-(int)getSeconds;

@end
