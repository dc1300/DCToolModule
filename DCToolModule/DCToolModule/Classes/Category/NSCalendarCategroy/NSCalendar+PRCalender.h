//
//  NSCalendar+PRCalender.h
//  PurangFinance
//
//  Created by liumingkui on 15/5/12.
//  Copyright (c) 2015年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (MySpecialCalculations)

/**
 计算起始日期和结束日期的时间差

 @param startDate 起始日期
 @param endDate 结束日期
 @return 时间差
 */
- (NSInteger)daysWithinEraFromDate:(NSDate *)startDate toDate:(NSDate *) endDate;

@end
