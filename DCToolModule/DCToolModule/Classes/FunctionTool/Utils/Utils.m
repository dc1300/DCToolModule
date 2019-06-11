//
//  Utils.m
//  PurangFinanceVillage
//
//  Created by purang\daichen on 2017/4/11.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/param.h>
#include <sys/mount.h>

#import "NSString+Judge.h"
#import "NSString+Extensions.h"
#import "UIColor+HexCode.h"

#import "SSKeychain.h"

@implementation Utils


//获取设备iOS系统版本
+ (NSString *)getDeviceVersion{
    return [[UIDevice currentDevice] systemVersion];
}

//获取设备号UUID
+ (NSString *)getDeviceID{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

//获取app版本号
+ (NSString *)getClientVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
//颜色转换图片
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (BOOL)image:(UIImage *)image isEqualToAnotherImage:(UIImage *)anotherImage{
    NSData *data = UIImagePNGRepresentation(image);
    NSData *data1 = UIImagePNGRepresentation(anotherImage);
    if ([data isEqual:data1]) {
        return YES;
    }
    return NO;
}

#pragma mark ------ 时间处理

+(NSDate *)addMonthDate:(NSDate *)now withMonths:(NSInteger)months {
    NSDateComponents *monthBeforeDateComponents = [[NSDateComponents alloc] init];
    monthBeforeDateComponents.month = months;
    NSDate *rsDate = [[NSCalendar currentCalendar]dateByAddingComponents:monthBeforeDateComponents toDate:now options:0];
    return rsDate;
}


+(NSDate *)addDayDate:(NSDate *)now withDays:(NSInteger)days {
    NSDateComponents *dayBeforeDateComponents = [[NSDateComponents alloc] init];
    dayBeforeDateComponents.day = days;
    NSDate *rsDate = [[NSCalendar currentCalendar]dateByAddingComponents:dayBeforeDateComponents toDate:now options:0];
    return rsDate;
}

+(NSString *)getCurrentyear {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

+(NSString *)getCurrentMonth {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

+(NSString *)getCurrentDateString {
    NSDate *now = [NSDate date];//根据当前系统的时区产生当前的时间，绝对时间，所以同为中午12点，不同的时区，这个时间是不同的。
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone systemTimeZone];//系统所在时区
    df.dateFormat = @"yyyyMMdd";
    NSString *systemTimeZoneStr =  [df stringFromDate:now];
    return systemTimeZoneStr;
}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

+(NSString *)getCurrentDateStringWithDateFormat:(NSString *)format {
    NSDate *now = [NSDate date];//根据当前系统的时区产生当前的时间，绝对时间，所以同为中午12点，不同的时区，这个时间是不同的。
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone systemTimeZone];//系统所在时区
    df.dateFormat = format;
    NSString *systemTimeZoneStr =  [df stringFromDate:now];
    return systemTimeZoneStr;
}

+(NSString *)formatDateString :(NSDate*)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *systemTimeZoneStr =  [df stringFromDate:date];
    return systemTimeZoneStr;
}

+(NSString *)strformatDateString :(NSDate*)date dateFormat:(NSString *)dateFormat{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//[NSTimeZone systemTimeZone];//系统所在时区
    df.dateFormat = dateFormat;
    NSString *systemTimeZoneStr =  [df stringFromDate:date];
    return systemTimeZoneStr;
}

+(NSDate *)dateformatDateString :(NSString*)dateStr dateFormat:(NSString *)dateFormat{
    
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"/" withString:@""];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    dateFormat = [dateFormat stringByReplacingOccurrencesOfString:@":" withString:@""];
    dateFormat = [dateFormat stringByReplacingOccurrencesOfString:@"/" withString:@""];
    dateFormat = [dateFormat stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:dateFormat];
    [dateFormater setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *date =[dateFormater dateFromString:dateStr];
    return date;
}

+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    int days=(time)/(3600*24);
    return days;
}

/**将format1格式的dateString转换成format2格式的字符*/
+ (NSString *)getTimeStr:(NSString *)dateString format1:(NSString *)formart1 format2:(NSString *)formart2{
    if ([NSString isBlankStringWith:dateString]) {
        return @"";
    }
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formart1];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *date =[dateFormat dateFromString:dateString];
    if (date == nil) {
        return @"";
    }
    NSDateFormatter* dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:formart2];
    [dateFormat2 setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSString *publishtimeStr = [dateFormat2 stringFromDate:date ];
    
    return publishtimeStr;
}


+(NSDate*)getTodayDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    return startDate;
    
}

+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    //    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}


+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr unitStr:(NSString *)unitStr titleColor:(UIColor *)titleColor unitColor:(UIColor *)unitColor titleFont:(NSInteger)titleFont unitFont:(NSInteger)unitFont{//图文混排
    
    titleStr = [NSString checkEmptyNoneFromThing:titleStr];
    unitStr = [NSString checkEmptyNoneFromThing:unitStr];
    NSMutableAttributedString *startString = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [startString addAttributes:@{
                                 NSForegroundColorAttributeName: titleColor,
                                 NSFontAttributeName:[UIFont systemFontOfSize:titleFont]
                                 } range:NSMakeRange(0, titleStr.length)];
    
    NSMutableAttributedString *endString = [[NSMutableAttributedString alloc] initWithString:unitStr];
    [endString addAttributes:@{
                               NSForegroundColorAttributeName: unitColor,
                               NSFontAttributeName:[UIFont systemFontOfSize:unitFont]
                               } range:NSMakeRange(0, unitStr.length)];
    
    
    [startString appendAttributedString:endString];
    return startString;
}
+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr titleColor:(UIColor *)titleColor unitFont:(NSInteger)unitFont imageName:(NSString *)imageName frame:(CGRect)frame location:(NSInteger)location{//图文混排带图片
    
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",titleStr]];
    
    [attri addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, titleStr.length)];
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:imageName];
    // 设置图片大小
    attch.bounds = frame;
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [attri insertAttributedString:string atIndex:location];
    
    [attri appendAttributedString:string];
    
    return attri;
}


+ (void)setAttributeStringForPriceLabel:(UILabel *)label text:(NSString *)text
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString
                                              alloc] initWithString:text];
    NSUInteger length = [text length];
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.tailIndent = -10; //设置与尾部的距离
    style.alignment = NSTextAlignmentRight;//靠右显示
    [attrString addAttribute:NSParagraphStyleAttributeName value:style
                       range:NSMakeRange(0, length)];
    label.attributedText = attrString;
}

+ (NSString *)getNumberStr:(NSString*)numberStr RangeIntValue:(NSInteger)rangIntValue{
    
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                                      scale:rangIntValue
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:NO
                                                                                           raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:NO];
    
    //    NSNumber *numberS = [NSNumber numberWithDouble:[numberStr doubleValue]];
    NSDecimalNumber *numberDec = [NSDecimalNumber decimalNumberWithString:numberStr];
    NSString *tempStr =[[numberDec decimalNumberByRoundingAccordingToBehavior:roundingBehavior] stringValue];
    NSLog(@"NSDecimalNumber method  rounding = %@",tempStr);
    return tempStr;
}




+ (NSString *)getResult:(NSDictionary *)dic text:(NSString *)text{
    NSArray *keys = [dic allKeys];
    NSString *result = @"";
    for (NSString *str in keys) {
        if ([text isEqualToString:str]) {
            result = dic[str];
            break;
        }
    }
    return result;
}

+ (NSString *)disable_emoji:(NSString *)text{
    //限制输入表情
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    [modifiedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [modifiedString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    [modifiedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return modifiedString;
}

+ (NSString *)getWeekTimeWith:(NSInteger)index
{
    
    
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1;
    if (weekDay == 1)
    {
        firstDiff = -6+index*7;
        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay + 1+index*7;
        lastDiff = 8 - weekDay+index*7;
    }
    NSLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@~%@",firstDay,lastDay];
    
    return dateStr;
    
}

+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(NSInteger)titleFont unitFont:(NSInteger)unitFont
{//图文混排
    
    NSRange range1 = [titleStr rangeOfString:@"."];
    
    if (range1.location == NSNotFound) {
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",titleStr]];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(0, title.length)];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:titleFont] range:NSMakeRange(0, title.length)];
        
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(title.length, titleStr.length-title.length)];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:unitFont] range:NSMakeRange(title.length, titleStr.length-title.length)];
        return attri;
    }else{
        
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",titleStr]];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(0, range1.location)];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:titleFont] range:NSMakeRange(0, range1.location)];
        
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(range1.location, titleStr.length-range1.location)];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:unitFont] range:NSMakeRange(range1.location, titleStr.length-range1.location)];
        return attri;
        
        
    }
    
}


+ (NSMutableAttributedString *)getLabelWithFontStr:(NSString *)titleStr title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(UIFont *)titleFont unitFont:(UIFont *)unitFont
{
    NSRange range1 = [titleStr rangeOfString:@"."];
    
    if (range1.location == NSNotFound) {
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",titleStr]];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(0, title.length)];
        [attri addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(0, title.length)];
        
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(title.length, titleStr.length-title.length)];
        [attri addAttribute:NSFontAttributeName value:unitFont range:NSMakeRange(title.length, titleStr.length-title.length)];
        return attri;
    }else{
        
        NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",titleStr]];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(0, range1.location)];
        [attri addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(0, range1.location)];
        
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:titleColor] range:NSMakeRange(range1.location, titleStr.length-range1.location)];
        [attri addAttribute:NSFontAttributeName value:unitFont range:NSMakeRange(range1.location, titleStr.length-range1.location)];
        return attri;
        
        
    }
}

+ (NSString *)freeDiskSpaceInByt{//获取设备剩余存储空间
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    
    if (freespace>1024*1024*1024){
        return [NSString stringWithFormat:@"%.1qiG",freespace/1024/1024/1024];//大于1G，则转化成G单位的字符串
    }
    else if(freespace<1024*1024*1024&&freespace>=1024*1024)//大于1M，则转化成M单位的字符串
    {
        return [NSString stringWithFormat:@"%.1qiM",freespace/1024/1024];
    }
    else if(freespace>=1024&&freespace<1024*1024) //不到1M,但是超过了1KB，则转化成KB单位
    {
        return [NSString stringWithFormat:@"%.1qiK",freespace/1024];
    }
    else//剩下的都是小于1K的，则转化成B单位
    {
        return [NSString stringWithFormat:@"%.1qiB",freespace];
    }
    
}
+(NSString *)addTwoNumberWithOneNumStr:(NSString *)one anotherNumStr:(NSString *)another
{
    int i = 0;
    int j = 0;
    int maxLength = 0;
    int sum = 0;
    int overflow = 0;
    int carryBit = 0;
    NSString *temp1 = @"";
    NSString *temp2 = @"";
    NSString *sums = @"";
    NSString *tempSum = @"";
    int length1 = (int)one.length;
    int length2 = (int)another.length;
    //1.反转字符串
    for (i = length1 - 1; i >= 0 ; i--) {
        NSRange range = NSMakeRange(i, 1);
        temp1 = [temp1 stringByAppendingString:[one substringWithRange:range]];
        NSLog(@"%@",temp1);
    }
    for (j = length2 - 1; j >= 0; j--) {
        NSRange range = NSMakeRange(j, 1);
        temp2 = [temp2 stringByAppendingString:[another substringWithRange:range]];
        NSLog(@"%@",temp2);
    }
    
    //2.补全缺少位数为0
    maxLength = length1 > length2 ? length1 : length2;
    if (maxLength == length1) {
        for (i = length2; i < length1; i++) {
            temp2 = [temp2 stringByAppendingString:@"0"];
            NSLog(@"i = %d --%@",i,temp2);
        }
    }else{
        for (j = length1; j < length2; j++) {
            temp1 = [temp1 stringByAppendingString:@"0"];
            NSLog(@"j = %d --%@",j,temp1);
        }
    }
    //3.取数做加法
    for (i = 0; i < maxLength; i++) {
        NSRange range = NSMakeRange(i, 1);
        int a = [temp1 substringWithRange:range].intValue;
        int b = [temp2 substringWithRange:range].intValue;
        sum = a + b + carryBit;
        if (sum > 9) {
            if (i == maxLength -1) {
                overflow = 1;
            }
            carryBit = 1;
            sum -= 10;
        }else{
            carryBit = 0;
        }
        tempSum = [tempSum stringByAppendingString:[NSString stringWithFormat:@"%d",sum]];
    }
    if (overflow == 1) {
        tempSum = [tempSum stringByAppendingString:@"1"];
    }
    int sumlength = (int)tempSum.length;
    for (i = sumlength - 1; i >= 0 ; i--) {
        NSRange range = NSMakeRange(i, 1);
        sums = [sums stringByAppendingString:[tempSum substringWithRange:range]];
    }
    NSLog(@"sums = %@",sums);
    return sums;
}

+(NSMutableDictionary*)getURLParametersWith:(NSString *)url {
    
    NSRange  range = [url rangeOfString:@"?"];
    
    if(range.location==NSNotFound) {
        
        return  nil;
        
    }
    
    NSMutableDictionary  *params = [NSMutableDictionary   dictionary];
    
    NSString  *parametersString = [url substringFromIndex:range.location+1];
    
    if([parametersString   containsString:@"&"]) {
        
        NSArray  *urlComponents = [parametersString   componentsSeparatedByString:@"&"];
        
        for(NSString *keyValuePair in urlComponents) {
            
            //生成key/value
            
            NSArray *pairComponents = [keyValuePair  componentsSeparatedByString:@"="];
            
            NSString *key;
            NSString*value;
            if (pairComponents.count != 2) {
                
                NSRange range = [keyValuePair rangeOfString:@"="];
                key = [keyValuePair substringToIndex:range.location];
                value = [keyValuePair substringFromIndex:range.location+1];
                
            }else{
                key = [pairComponents.firstObject  stringByRemovingPercentEncoding];
                value = [pairComponents.lastObject  stringByRemovingPercentEncoding];
            }
            
            
            //key不能为nil
            
            if(key==nil|| value ==nil) {
                
                continue;
                
            }
            
            id existValue = [params valueForKey:key];
            
            if(existValue !=nil) {
                
                //已存在的值，生成数组。
                
                if([existValue  isKindOfClass:[NSArray  class]]) {
                    
                    //已存在的值生成数组
                    
                    NSMutableArray*items = [NSMutableArray arrayWithArray:existValue];
                    
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                    
                }else{
                    
                    //非数组
                    
                    [params setValue:@[existValue,value]forKey:key];
                    
                }
                
            }else{
                
                //设置值
                
                [params setValue:value forKey:key];
                
            }
            
        }
        
    }else{
        
        //单个参数生成key/value
        
        NSArray *pairComponents = [parametersString  componentsSeparatedByString:@"="];
        
        if(pairComponents.count==1) {
            
            return nil;
            
        }
        
        //分隔值
        NSString *key;
        NSString *value;
        
        if (pairComponents.count==2) {
            key = [pairComponents.firstObject  stringByRemovingPercentEncoding];
            
            value = [pairComponents.lastObject  stringByRemovingPercentEncoding];
        }else{
            
            key = [pairComponents.firstObject  stringByRemovingPercentEncoding];
            
            //            NSRange range=[parametersString rangeOfString:@"="];
            //
            //            value=[parametersString substringFromIndex:range.location+1];
            
            value = [parametersString  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@=",key] withString:@""];
            
        }
        
        
        
        //key不能为nil
        
        if(key ==nil|| value ==nil) {
            
            return nil;
            
        }
        
        //设置值
        
        [params setValue:value forKey:key];
        
    }
    
    return params;
    
}
+ (UIImage *)compressedImageFiles:(UIImage *)image
                          imageKB:(CGFloat)fImageKBytes{
    
    __block UIImage *imageCope = image;
    CGFloat fImageBytes = fImageKBytes * 1024;//需要压缩的字节Byte
    
    __block NSData *uploadImageData = nil;
    
    uploadImageData = UIImagePNGRepresentation(imageCope);
    NSLog(@"图片压前缩成 %fKB",uploadImageData.length/1024.0);
    CGSize size = imageCope.size;
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    
    if (uploadImageData.length > fImageBytes && fImageBytes >0) {
        
        /* 宽高的比例 **/
        CGFloat ratioOfWH = imageWidth/imageHeight;
        /* 压缩率 **/
        CGFloat compressionRatio = fImageBytes/uploadImageData.length;
        /* 宽度或者高度的压缩率 **/
        CGFloat widthOrHeightCompressionRatio = sqrt(compressionRatio);
        
        CGFloat dWidth   = imageWidth *widthOrHeightCompressionRatio;
        CGFloat dHeight  = imageHeight*widthOrHeightCompressionRatio;
        if (ratioOfWH >0) { /* 宽 > 高,说明宽度的压缩相对来说更大些 **/
            dHeight = dWidth/ratioOfWH;
        }else {
            dWidth  = dHeight*ratioOfWH;
        }
        
        imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
        uploadImageData = UIImagePNGRepresentation(imageCope);
        
        NSLog(@"当前的图片已经压缩成 %fKB",uploadImageData.length/1024.0);
        //微调
        NSInteger compressCount = 0;
        /* 控制在 10M 以内**/
        while (fabs(uploadImageData.length - fImageBytes) > 10) {
            /* 再次压缩的比例**/
            CGFloat nextCompressionRatio = 0.9;
            
            if (uploadImageData.length > fImageBytes) {
                dWidth = dWidth*nextCompressionRatio;
                dHeight= dHeight*nextCompressionRatio;
            }else {
                dWidth = dWidth/nextCompressionRatio;
                dHeight= dHeight/nextCompressionRatio;
            }
            
            imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
            uploadImageData = UIImagePNGRepresentation(imageCope);
            
            /*防止进入死循环**/
            compressCount ++;
            if (compressCount == 20) {
                break;
            }
            
        }
        
        NSLog(@"图片已经压缩成 %fKB",uploadImageData.length/1024.0);
        imageCope = [[UIImage alloc] initWithData:uploadImageData];
        return imageCope;
    }
    else
    {
        return imageCope;
    }
}




/* 根据 dWidth dHeight 返回一个新的image**/
+ (UIImage *)drawWithWithImage:(UIImage *)imageCope width:(CGFloat)dWidth height:(CGFloat)dHeight{
    
    UIGraphicsBeginImageContext(CGSizeMake(dWidth, dHeight));
    [imageCope drawInRect:CGRectMake(0, 0, dWidth, dHeight)];
    imageCope = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCope;
    
}


+(UIButton *)establishBtnWith:(CGRect)frame title:(NSString *)title font:(NSInteger)font color:(UIColor *)color image:(NSString *)image type:(UIButtonType)type
{
    UIButton * btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (![NSString isBlankStringWith:image]) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    return btn;
}


+ (UIViewController *)getTopViewController{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *vc = window.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        if ([vc isKindOfClass:[UIAlertController class]]) {
            vc = vc.parentViewController;
        }
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = [(UITabBarController *)vc selectedViewController];
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController *)vc topViewController];
    }
    return vc;
}

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+(UIViewController *)getCurrentVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}

+ (NSString *)getTokenWith:(NSString *)serviceKey{
    NSError * error = nil;
    NSString * token = [SSKeychain passwordForService:serviceKey account:@"token" error:&error];
    if ([error code] == SSKeychainErrorNotFound) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        assert(uuid != NULL);
        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
        
        [SSKeychain setPassword: [NSString stringWithFormat:@"%@", uuidStr]
                     forService:serviceKey account:@"token"];
        NSString *retrieveuuid = [SSKeychain passwordForService:serviceKey account:@"token"];
        token = retrieveuuid;
    }
    return token;
}



@end
