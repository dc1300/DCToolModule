//
//  Utils.h
//  PurangFinanceVillage
//
//  Created by purang\daichen on 2017/4/11.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

//颜色转换图片
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (BOOL)image:(UIImage *)image isEqualToAnotherImage:(UIImage *)anotherImage;
//获取设备iOS系统版本
+ (NSString *)getDeviceVersion;
//获取设备号UUID
+ (NSString *)getDeviceID;
//获取app版本号
+ (NSString *)getClientVersion;

#pragma mark ---- 时间处理

+(NSDate*)addMonthDate:(NSDate*) now withMonths:(NSInteger) months;
+(NSDate *)addDayDate:(NSDate *)now withDays:(NSInteger)days;
//获取当前年份
+(NSString *)getCurrentyear;
//获取当前月份
+(NSString *)getCurrentMonth;
//获取当前时区时间 格式yyyyMMdd
+(NSString *)getCurrentDateString ;
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
//获取当前时区时间 格式format
+(NSString *)getCurrentDateStringWithDateFormat:(NSString *)format ;
//获取yyyy-MM-dd时间
+(NSString *)formatDateString :(NSDate*)date;
//获取dateFormat格式时间
+(NSString *)strformatDateString :(NSDate*)date dateFormat:(NSString *)dateFormat;
+(NSDate *)dateformatDateString :(NSString*)dateStr dateFormat:(NSString *)dateFormat;
//endDate - beginDate 天数
+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;
/**获取今天的零点的date*/
+(NSDate*)getTodayDate;

/**将format1格式的dateString转换成format2格式的字符*/
+ (NSString *)getTimeStr:(NSString *)dateString format1:(NSString *)formart1 format2:(NSString *)formart2;

/**比较day1和day2大小  1—>day1大 -1->day2大 0->相同*/
+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

//图文混排
+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr unitStr:(NSString *)unitStr titleColor:(UIColor *)titleColor unitColor:(UIColor *)unitColor titleFont:(NSInteger)titleFont unitFont:(NSInteger)unitFont;
+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr titleColor:(UIColor *)titleColor unitFont:(NSInteger)unitFont imageName:(NSString *)imageName frame:(CGRect)frame location:(NSInteger)location;

//小数点后的图文混排

+ (NSMutableAttributedString *)getLabelWithStr:(NSString *)titleStr title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(NSInteger)titleFont unitFont:(NSInteger)unitFont;

+ (NSMutableAttributedString *)getLabelWithFontStr:(NSString *)titleStr title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(UIFont *)titleFont unitFont:(UIFont *)unitFont;


/**label右对齐但有10的距离*/
+ (void)setAttributeStringForPriceLabel:(UILabel *)label text:(NSString *)text;
/**字符串取位数四舍五入*/
+ (NSString *)getNumberStr:(NSString*)numberStr RangeIntValue:(NSInteger)rangIntValue;


+ (NSString *)getResult:(NSDictionary *)dic text:(NSString *)text;
//限制输入表情
+ (NSString *)disable_emoji:(NSString *)text;
//后取周数据
+ (NSString *)getWeekTimeWith:(NSInteger)index;
//获取设备剩余存储空间
+ (NSString *)freeDiskSpaceInByt;
//计算超大数字之和
+(NSString *)addTwoNumberWithOneNumStr:(NSString *)one anotherNumStr:(NSString *)another;
//获取url中的数据
+(NSMutableDictionary*)getURLParametersWith:(NSString *)url;

+(UIImage *)compressedImageFiles:(UIImage *)image
                          imageKB:(CGFloat)fImageKBytes;


+(UIButton *)establishBtnWith:(CGRect)frame title:(NSString *)title font:(NSInteger)font color:(UIColor *)color image:(NSString *)image type:(UIButtonType)type;

//获取当前最上层控制器
+(UIViewController *)getTopViewController;
//字典转json
+(NSString *)convertToJsonData:(NSDictionary *)dict;


+(UIViewController *)getCurrentVC;

+ (NSString *)getTokenWith:(NSString *)serviceKey;

@end
