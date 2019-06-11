//
//  NSString+Extensions.h
//  PurangFinanceVillage-Bank
//
//  Created by wangyilu on 16/1/27.
//  Copyright © 2016年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PasswordStrength) {
    weakPassword,                                   //弱
    normalPassword,                                 //中
    strongPassword,                                 //强
};

@interface NSString (Extensions)

#pragma mark - 身份证数据处理
//根据身份证号获取性别
+(NSString *)getIdentityCardSex:(NSString *)numberStr;
//根据身份证号获取生日
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;
//根据身份证号获取年龄
+(NSString *)getIdentityCardAge:(NSString *)numberStr;



#pragma mark 字符串处理
/*
 判断thing是否为空 为空返回 @"--"
 */
+ (NSString *)checkEmptyFromThing:(id)thing;
/*
 判断thing是否为空 为空返回 @""
 */
+ (NSString *)checkEmptyNoneFromThing:(id)thing;
/*
 判断thing是否为空 为空返回 @"0"
 */
+ (NSString *)checkEmptyZeroFromThing:(id)thing;

- (NSString *)pr_checkEmptyReplaceString:(NSString *)replace;
/*
 去掉小数点后面的0
 */
+ (NSString *)removeFloatAllZero:(NSString *)string;
/*
 最多2位小数，去掉小数点后面的0
 */
+ (NSString *)removeSecondFloatAllZero:(NSString *)string;
/* 拿到字符串最后一位 */
+ (NSString *)lastCharFromString:(NSString *)string;
/* 拿到字符串第一位 */
+ (NSString *)firstCharFromString:(NSString *)string;
/* 拿到字符串最后一位 */
- (NSString *)lastChar;
/* 拿到字符串第一位 */
- (NSString *)firstChar;
/**数字加千位符号*/
+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString;
//隐藏手机号中间四位
- (NSString *)numberSuitScanf;
#pragma mark - 日期
/*判断日期 返回  yy-MM dd:HH*/
+ (NSString *)checkDateFromThing:(id)thing;
/* 日期 yyyyMMdd —> yyyy-MM-dd */
+ (NSString *)addSpaceMarkWithDateStr:(NSString *)string;
/* 拿到日期 yyyy-MM-dd */
+ (NSString *)searchYearMonthDayString:(NSString *)string;
/* 拿到日期 HH-mm-ss */
+ (NSString*)searchHourMinSecString:(NSString *)string;


#pragma mark - tool 方法

/*
 * Returns the long value of the string
 */
- (long)longValue;

/**
 *  去除首尾空格和换行符
 */
- (NSString *)trimWhiteCharacters;

/**
 计算文本的宽度或者高度

 @param font 字体大小
 @param size size  计算宽度（MAXFLOAT,height） 计算高度（width,MAXFLOAT）
 @return size
 */
- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size;

/**
 *  计算字符串宽度(指当该字符串放在view时的自适应宽度)
 *
 *  @param size 填入预留的大小
 *  @param font 字形
 *
 *  @return 返回CGRect
 */
- (CGRect)stringWidthRectWithSize:(CGSize)size font:(UIFont *)font;

/**
 URL编码
 
 @return NSString
 */
- (NSString *)urlencode;

/**
 URl解码
 
 @return NSString
 */
- (NSString *)urldecode;

/**
 去掉数字字符串小数点后面无用的0
 
 @return NSString
 */
- (NSString *)stringWithCustomPriceFormat;

/**
 判断密码强弱
 
 @return PasswordStrength
 */
- (PasswordStrength)isStrengthPwd;

/**
 安全获取obj的内容 剔除(null)内容
 
 @param obj 内容
 
 @return NSString
 */
+ (NSString *)safeFormatString:(id)obj;

/**
 转成数字格式为 千，百十个
 
 @return 转化后的str
 */
- (NSString*)changeToCurrencyString;

/**
 array 转化为json 字符串
 
 @param array 数组
 @return json 字符串
 */
+ (NSString *)convertArrayToString:(NSArray *)array;

#pragma mark - URL Types

/**
 腾讯支付URL type
 
 @return NSString
 */
+ (NSString *)stringTenPaySourceApplication;

/**
 阿里pay URL Type
 
 @return NSString
 */
+ (NSString *)stringAlixPaySourceApplication;

/**
 阿里pay URL Type
 
 @return NSString
 */
+ (NSString *)stringAlixPaySourceApplication2;

/**
 获取阿里pay URLScheme
 
 @return NSString
 */
+ (NSString *)stringAlixPayURLScheme;

/**
 获取weixin URLScheme
 
 @return NSString
 */
+ (NSString *)stringWeiXinShareURLScheme;

/**
 获取新浪微博 URLScheme
 
 @return NSString
 */
+ (NSString *)stringSinaWeiBoShareURLScheme;

/**
 获取万汇网 URLScheme
 
 @return NSString
 */
+ (NSString *)stringWanHuiURLScheme;

/**
 通过key值获取URL scheme
 
 @param keyworkd 关键字
 
 @return NSString
 */
+ (NSString *)stringURLSchemeWithKeyword:(NSString *)keyworkd;

#pragma mark - 数字格式化
/**
 钱数格式化
 */
+ (NSString *)bss_moneyFormatWithDouble:(double)count;
/**
 钱数格式化
 */
+ (NSString *)bss_moneyFormat:(NSString *)count;
/**
 *  数字“万化”
 *
 *  @param count 数字
 *
 *  @return 字符串
 */
+ (NSString *)bss_wanFormat:(NSInteger)count;
/**
 *  数字"千"格式化
 *
 *  @param count 数字
 *
 *  @return 字符串
 */
+ (NSString *)bss_thousandFormat:(NSInteger)count;

/**
 *  数字格式化
 *
 *  @param count 数字
 *
 *  @return 字符串
 */
+ (NSString *)bss_numFormat:(NSInteger)count;


@end
