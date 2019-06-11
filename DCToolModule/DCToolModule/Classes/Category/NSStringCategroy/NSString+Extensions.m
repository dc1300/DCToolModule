//
//  NSString+Extensions.m
//  PurangFinanceVillage-Bank
//
//  Created by wangyilu on 16/1/27.
//  Copyright © 2016年 ___PURANG___. All rights reserved.
//

#import "NSString+Extensions.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+Judge.h"

@implementation NSString (Extensions)

#pragma mark - 身份证数据处理
//根据身份证号获取性别
+(NSString *)getIdentityCardSex:(NSString *)numberStr{
    int sexInt=[[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
    
    if(sexInt%2!=0){
        return @"1";
    }
    else{
        return @"0";
    }
}
//根据身份证号获取年龄
+(NSString *)getIdentityCardAge:(NSString *)numberStr{
    
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    [formatterTow setDateFormat:@"yyyy-MM-dd"];
    NSDate *bsyDate = [formatterTow dateFromString:[self birthdayStrFromIdentityCard:numberStr]];
    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    int age = trunc(dateDiff/(60*60*24))/365;
    return [NSString stringWithFormat:@"%d",-age];
}
//根据身份证号获取生日
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    
    NSString *day = nil;
    if([numberStr length]<14)
        return result;
    
    //**截取前14位
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 14)];
    
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    
    year = [numberStr substringWithRange:NSMakeRange(6, 4)];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
}

#pragma mark 字符串处理
- (NSString *)pr_checkEmptyReplaceString:(NSString *)replace{
    
    if ([NSString isBlankStringWith:self]) {
        return replace;
    }else{
        if (self == nil) {
            return replace;
        }
        return [NSString stringWithFormat:@"%@",self];
    }
}
+ (NSString *)checkEmptyFromThing:(id)thing{
    NSString *string = nil;
    if ([NSString isBlankStringWith:thing]) {
        string = @"--";
    }else{
        string = [NSString stringWithFormat:@"%@",thing];
    }
    return string;
}
+ (NSString *)checkEmptyNoneFromThing:(id)thing{
    NSString *string = nil;
    if ([NSString isBlankStringWith:thing]) {
        string = @"";
    }else{
        string = [NSString stringWithFormat:@"%@",thing];
    }
    return string;
}
+ (NSString *)checkEmptyZeroFromThing:(id)thing{
    NSString *string = nil;
    if ([NSString isBlankStringWith:thing]) {
        string = @"0";
    }else{
        string = [NSString stringWithFormat:@"%@",thing];
    }
    return string;
}
+ (NSString*)removeFloatAllZero:(NSString*)string{
    if ((![string isKindOfClass:[NSString class]] && [NSString isBlankStringWith:string]) || string.length == 0) {
        return @"";
    }
    NSString * s = nil;
    NSInteger offset = string.length - 1;
    while (offset){
        if ([string containsString:@"."]) {
            s = [string substringWithRange:NSMakeRange(offset, 1)];
            if ([s isEqualToString:@"0"] || [s isEqualToString:@"."]){
                offset--;
                string = [string substringToIndex:offset+1];
            } else{
                break;
            }
        }else{
            break;
        }
    }
    NSString * outNumber = [string substringToIndex:offset+1];
    if ([outNumber isEqualToString:@"0"]) {
        return @"";
    }
    return outNumber;
}
+ (NSString*)removeSecondFloatAllZero:(NSString*)string{
    if ([NSString isBlankStringWith:string]) {
        return @"--";
    }else{
        NSString *newStr = [NSString stringWithFormat:@"%.2lf",[string doubleValue]];
        return [self removeFloatAllZero:newStr];
    }
}
+ (NSString *)lastCharFromString:(NSString*)string{
    if ((![string isKindOfClass:[NSString class]] && [NSString isBlankStringWith:string]) || string.length == 0) {
        return @"";
    }
    return [string substringFromIndex:string.length-1];
}
+ (NSString *)firstCharFromString:(NSString *)string{
    if ((![string isKindOfClass:[NSString class]] && [NSString isBlankStringWith:string]) || string.length == 0) {
        return @"";
    }
    
    return [string substringToIndex:1];
}
- (NSString *)lastChar{
    return [NSString lastCharFromString:self];
}
- (NSString *)firstChar{
    return [NSString firstCharFromString:self];
}
+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *numberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[digitString doubleValue]]];
    return numberString;
}
- (NSString *)numberSuitScanf{
    
    BOOL isOk = [NSString checkPhoneNumInputWith:self];
    if (isOk) {//如果是手机号码的话
        NSString *numberString = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return numberString;
    }
    return self;
}

#pragma mark - 日期

+ (NSString *)checkDateFromThing:(id)thing{
    if ([NSString isBlankStringWith:thing]) {
        return @"";
    }
    NSString *string = [NSString stringWithFormat:@"%@",thing];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    NSInteger count = (string.length+1)/2;
    for (int i = 0; i < count;i++) {
        NSString *sec = [string substringToIndex:2];
        [temp addObject:sec];
        string = [string substringFromIndex:2];
    }
    if (temp.count < 5) {
        return string;
    }
    return [NSString stringWithFormat:@"%@-%@ %@:%@",temp[1],temp[2],temp[3],temp[4]];
}
+ (NSString*)addSpaceMarkWithDateStr:(NSString*)string{
    if (string.length != 8) return string;
    
    NSMutableString *mutStr = [[NSMutableString alloc]initWithString:string];
    [mutStr insertString:@"-" atIndex:4];
    [mutStr insertString:@"-" atIndex:7];
    return mutStr;
}
+ (NSString*)searchYearMonthDayString:(NSString*)string{
    if ([NSString isBlankStringWith:string]) {
        return @"--";
    }
    NSArray *temp = [string componentsSeparatedByString:@" "];
    return [temp firstObject];
}
+ (NSString*)searchHourMinSecString:(NSString*)string{
    if ([NSString isBlankStringWith:string]) {
        return @"--";
    }
    NSArray *temp = [string componentsSeparatedByString:@" "];
    return [temp lastObject];
}



- (NSString *)trimWhiteCharacters {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 
 * 功能:获取指定范围的字符串
 
 * 参数:字符串的开始小标
 
 * 参数:字符串的结束下标
 
 */

- (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger )value2;
{
    return [str substringWithRange:NSMakeRange(value1,value2)];
}

- (NSString*)changeToCurrencyString {
    NSNumberFormatter *formatter= [[NSNumberFormatter alloc]init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber* number = [formatter numberFromString:self];
    if (number) {
        NSString* newString = [formatter stringFromNumber:number];
        return newString;
    }
    return self;
}

+ (NSString *)convertArrayToString:(NSArray *)array {
    NSError* parseError =nil;
    
    //options=0转换成不带格式的字符串
    //options=NSJSONWritingPrettyPrinted格式化输出
    if (![array isKindOfClass:[NSNull class]]) {
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:&parseError];
        return[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return @"";
}

//根据字符串的字体和size(此处size设置为字符串宽和MAXFLOAT)返回多行显示时的字符串size
- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size {
    CGSize resultSize;
        //段落样式
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    
    //字体大小，换行模式
    NSDictionary *attributes = @{NSFontAttributeName : font , NSParagraphStyleAttributeName : style};
    resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return resultSize;
}

/*
 * Returns the long value of the string
 */
- (long)longValue {
    return (long)[self longLongValue];
}

- (long long)longLongValue {
    NSScanner* scanner = [NSScanner scannerWithString:self];
    long long valueToGet;
    if([scanner scanLongLong:&valueToGet] == YES) {
        return valueToGet;
    } else {
        return 0;
    }
}

- (NSString *)urlencode {
    NSMutableCharacterSet *set = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [set removeCharactersInString:@"'\";:@&=$,/?%#[] "];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:set];
}

- (NSString *)urldecode {
    return [self stringByRemovingPercentEncoding];
}

- (NSString *)stringWithCustomPriceFormat {
    if (!self || self.length <= 0) {
        return @"";
    }
    
    NSMutableString *mutableStr = [NSMutableString stringWithString:self];
    if ([[mutableStr substringFromIndex:mutableStr.length-1] isEqualToString:@"0"] && [mutableStr rangeOfString:@"."].location != NSNotFound) {
        [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length-1, 1)];
        return [mutableStr stringWithCustomPriceFormat];
    }
    
    if ([[mutableStr substringFromIndex:mutableStr.length-1] isEqualToString:@"."]) {
        [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length-1, 1)];
    }
    
    return mutableStr;
}

- (PasswordStrength)isStrengthPwd {
    if (!self || self.length <= 0) {
        return weakPassword;
    }
    
    NSString *combineTwoStrong1 = @"(?=^.{13,}$)(?=.*[0-9])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineTwoStrong2 = @"(?=^.{13,}$)(?=.*[0-9])(?=.*[A-Z]).*$";
    NSString *combineTwoStrong3 = @"(?=^.{13,}$)(?=.*[0-9])(?=.*[a-z]).*$";
    NSString *combineTwoStrong4 = @"(?=^.{13,}$)(?=.*[a-z])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineTwoStrong5 = @"(?=^.{13,}$)(?=.*[A-Z])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineTwoStrong6 = @"(?=^.{13,}$)(?=.*[A-Z])(?=.*[a-z]).*$";
    NSString *combineTwoNormal1 = @"(?=^.{8,12}$)(?=.*[0-9])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineTwoNormal2 = @"(?=^.{8,12}$)(?=.*[0-9])(?=.*[A-Z]).*$";
    NSString *combineTwoNormal3 = @"(?=^.{8,12}$)(?=.*[0-9])(?=.*[a-z]).*$";
    NSString *combineTwoNormal4 = @"(?=^.{8,12}$)(?=.*[a-z])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineTwoNormal5 = @"(?=^.{8,12}$)(?=.*[A-Z])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineTwoNormal6 = @"(?=^.{8,12}$)(?=.*[A-Z])(?=.*[a-z]).*$";
    
    NSString *combineThreeStrong1 = @"(?=^.{11,}$)(?=.*[0-9])(?=.*[A-Z])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineThreeStrong2 = @"(?=^.{11,}$)(?=.*[0-9])(?=.*[a-z])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineThreeStrong3 = @"(?=^.{11,}$)(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).*$";
    NSString *combineThreeStrong4 = @"(?=^.{11,}$)(?=.*[a-z])(?=.*[A-Z])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineThreeNormal1 = @"(?=^.{8,10}$)(?=.*[0-9])(?=.*[A-Z])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineThreeNormal2 = @"(?=^.{8,10}$)(?=.*[0-9])(?=.*[a-z])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineThreeNormal3 = @"(?=^.{8,10}$)(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).*$";
    NSString *combineThreeNormal4 = @"(?=^.{8,10}$)(?=.*[a-z])(?=.*[A-Z])(?=.*\\W+)(?!.*\n).*$";
    
    NSString *combineAllStrong = @"(?=^.{10,}$)(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*\\W+)(?!.*\n).*$";
    NSString *combineAllNormal = @"(?=^.{8,9}$)(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*\\W+)(?!.*\n).*$";
    
    NSPredicate *combinePredAllStrong = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineAllStrong];
    NSPredicate *combinePredAllNormal = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineAllNormal];
    
    NSPredicate *combinePredThreeStrong1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineThreeStrong1];
    NSPredicate *combinePredThreeStrong2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineThreeStrong2];
    NSPredicate *combinePredThreeStrong3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineThreeStrong3];
    NSPredicate *combinePredThreeStrong4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineThreeStrong4];
    NSPredicate *combinePredThreeNormal1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineThreeNormal1];
    NSPredicate *combinePredThreeNormal2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineThreeNormal2];
    NSPredicate *combinePredThreeNormal3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineThreeNormal3];
    NSPredicate *combinePredThreeNormal4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineThreeNormal4];
    
    NSPredicate *combinePredTwoStrong1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoStrong1];
    NSPredicate *combinePredTwoStrong2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoStrong2];
    NSPredicate *combinePredTwoStrong3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoStrong3];
    NSPredicate *combinePredTwoStrong4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoStrong4];
    NSPredicate *combinePredTwoStrong5 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoStrong5];
    NSPredicate *combinePredTwoStrong6 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoStrong6];
    NSPredicate *combinePredTwoNormal1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoNormal1];
    NSPredicate *combinePredTwoNormal2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoNormal2];
    NSPredicate *combinePredTwoNormal3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoNormal3];
    NSPredicate *combinePredTwoNormal4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoNormal4];
    NSPredicate *combinePredTwoNormal5 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoNormal5];
    NSPredicate *combinePredTwoNormal6 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",combineTwoNormal6];
    
    if ([combinePredAllStrong evaluateWithObject:self] == YES)
    {
        return strongPassword;
        
    }else if ([combinePredAllNormal evaluateWithObject:self] == YES)
    {
        return normalPassword;
        
    }else if ([combinePredThreeStrong1 evaluateWithObject:self] == YES ||
              [combinePredThreeStrong2 evaluateWithObject:self] == YES ||
              [combinePredThreeStrong3 evaluateWithObject:self] == YES ||
              [combinePredThreeStrong4 evaluateWithObject:self] == YES)
    {
        return strongPassword;
        
    }else if ([combinePredThreeNormal1 evaluateWithObject:self] == YES ||
              [combinePredThreeNormal2 evaluateWithObject:self] == YES ||
              [combinePredThreeNormal3 evaluateWithObject:self] == YES ||
              [combinePredThreeNormal4 evaluateWithObject:self] == YES)
    {
        return normalPassword;
        
    }else if ([combinePredTwoStrong1 evaluateWithObject:self] == YES ||
              [combinePredTwoStrong2 evaluateWithObject:self] == YES ||
              [combinePredTwoStrong3 evaluateWithObject:self] == YES ||
              [combinePredTwoStrong4 evaluateWithObject:self] == YES ||
              [combinePredTwoStrong5 evaluateWithObject:self] == YES ||
              [combinePredTwoStrong6 evaluateWithObject:self] == YES)
    {
        return strongPassword;
        
    }else if ([combinePredTwoNormal1 evaluateWithObject:self] == YES ||
              [combinePredTwoNormal2 evaluateWithObject:self] == YES ||
              [combinePredTwoNormal3 evaluateWithObject:self] == YES ||
              [combinePredTwoNormal4 evaluateWithObject:self] == YES ||
              [combinePredTwoNormal5 evaluateWithObject:self] == YES ||
              [combinePredTwoNormal6 evaluateWithObject:self] == YES)
    {
        return normalPassword;
        
    }else
    {
        return weakPassword;
    }
}

+ (NSString *)safeFormatString:(id)obj {
    if (!obj) {
        return @"";
    } else if ([obj isKindOfClass:[NSString class]]) {
        if ([obj isEqualToString:@"(null)"]) {
            return @"";
        }
        return obj;
    } else if ([obj isKindOfClass:[NSNull class]]) {
        return @"";
    } else {
        return [obj description];
    }
}

+ (NSString *)stringTenPaySourceApplication {
    return @"com.tenpay.mobile.iphone";
}

+ (NSString *)stringAlixPaySourceApplication {
    return @"com.alipay.safepayclient";
}

+ (NSString *)stringAlixPaySourceApplication2 {
    return @"com.alipay.iphoneclient";
}

+ (NSString *)stringAlixPayURLScheme {
    return [NSString stringURLSchemeWithKeyword:@"AlixPay"];
}

+ (NSString *)stringWeiXinShareURLScheme {
    return [NSString stringURLSchemeWithKeyword:@"weixinshare"];
}

+ (NSString *)stringSinaWeiBoShareURLScheme {
    return [NSString stringURLSchemeWithKeyword:@"sinaweibo"];
}

+ (NSString *)stringWanHuiURLScheme {
    return [NSString stringURLSchemeWithKeyword:@"com.wanda.weburl"];
}

+ (NSString *)stringURLSchemeWithKeyword:(NSString *)keyworkd {
    NSArray *ary = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    for (NSDictionary *dic in ary) {
        NSString *urlName = [dic objectForKey:@"CFBundleURLName"];
        if ([urlName isEqualToString:keyworkd]) {
            NSArray *schemes = [dic objectForKey:@"CFBundleURLSchemes"];
            for (NSString *scheme in schemes) {
                if (scheme.length > 0) {
                    return scheme;
                }
            }
        }
    }
    return @"";
}

- (CGRect)stringWidthRectWithSize:(CGSize)size font:(UIFont *)font{
    NSDictionary * attributes = @{NSFontAttributeName: font};
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}


+ (NSString *)bss_moneyFormatWithDouble:(double)count{
    return [NSString bss_moneyFormat:[NSString stringWithFormat:@"%.2lf",count]];
}

+ (NSString *)bss_moneyFormat:(NSString *)count{
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    moneyFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    moneyFormatter.maximumFractionDigits = 2;
    return [moneyFormatter stringFromNumber:[[NSDecimalNumber alloc]initWithString:count]];
}
+ (NSString *)bss_wanFormat:(NSInteger)count{
    if (count < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)count];
    }
    return [NSString stringWithFormat:@"%.2lf万",count/10000.0];
}

+ (NSString *)bss_thousandFormat:(NSInteger)count{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:[NSNumber numberWithInteger:count]];
}

+ (NSString *)bss_numFormat:(NSInteger)count{
    if (count < 10000){
        return [NSString bss_thousandFormat:count];
    }else{
        double score = count/10000.0;
        score = floor(score * 100);
        score = score/100;
        return [NSString stringWithFormat:@"%.2lf万",score];
    }
}

@end
