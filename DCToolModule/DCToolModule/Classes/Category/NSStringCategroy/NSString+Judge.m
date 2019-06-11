//
//  NSString+Judge.m
//  MBProgressHUD
//
//  Created by zhoujunchun on 2019/3/13.
//

#import "NSString+Judge.h"
static inline BOOL ThingIsEmpty (id thing) {
    return thing == nil || [thing isEqual:[NSNull null]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

@implementation NSString (Judge)

+ (BOOL)checkIdentityCardWith:(NSString *)str
{
    //判断位数
    if ([str length] != 15 && [str length] != 18) {
        return NO;
    }
    NSString *carid = str;
    long lSumQT =0;
    //加权因子
    NSInteger R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:str];
    if ([str length] == 15)
    {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (NSInteger i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        NSInteger o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince])
    {
        return NO;
    }
    //判断年月日是否有效
    //年份
    NSInteger strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    NSInteger strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    NSInteger strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 12:01:01",(long)strYear,(long)strMonth,(long)strDay]];
    if (date == nil)
    {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (NSInteger i=0; i<18; i++)
    {
        
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    //验证最末的校验码
    for (NSInteger i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}
/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始小标
 * 参数:字符串的结束下标
 */
+ (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger )value2;
{
    return [str substringWithRange:NSMakeRange(value1,value2)];
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 **/
+ (BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil)
    {
        return NO;
    }
    return YES;
}

+ (BOOL)checkEmailInputWith:(NSString *)str
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}

+ (BOOL)numInputShouldNumberWith:(NSString *)str{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

+ (BOOL)bigString:(NSString *)bigString containString:(NSString *)string{
    NSArray  *array = [bigString componentsSeparatedByString:@","];//--分隔符
    for (NSString *str in array) {
        if ([str isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

//校验输入的是否是电话
+ (BOOL)checkPhoneNumInputWith:(NSString *)str{
    if ([self isBlankStringWith:str]) {
        return NO;
    }
    if (str.length != 11){
        return NO;
    }
    else{
        return YES;
    }
}

+ (BOOL)isBlankStringWith:(id)str {
    
    return ThingIsEmpty(str);
//    if (![str isKindOfClass:[NSString class]]) {
//        return YES;
//    }
//    if (str == nil || str == NULL) {
//        return YES;
//    }
//    if ([str isKindOfClass:[NSNull class]]) {
//        return YES;
//    }
//    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
//        return YES;
//    }
//    return NO;
}
+ (BOOL)isNotEmptyWith:(NSString *)str
{
    NSString *trimmed = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmed.length > 0;
}

+ (BOOL)isContainPhoneWith:(NSString *)str{
    NSString *needMobile = @"";
    for (int i = 0; i < str.length; i++) {
        NSString *temp = [str substringWithRange:NSMakeRange(i,1)];
        if ([temp isEqualToString:@"1"]) {
            NSInteger k = i;
            if (k + 11 <= str.length) {
                needMobile = [str substringWithRange:NSMakeRange(k, 11)];
                if ([self checkPhoneNumInputWith:needMobile]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}


- (BOOL)containsString:(NSString *)string {
    return [self containsString:string options:NSCaseInsensitiveSearch];
}

- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options {
    return [self rangeOfString:string options:options].location == NSNotFound ? NO : YES;
}

+ (BOOL)canTelWith:(NSString *)str {
    if (!str || str.length <= 0) {
        return NO;
    }
    //    telStr = [telStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *telStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    telStr = [telStr stringByReplacingOccurrencesOfString:@"转" withString:@","];
    if (!(telStr && telStr.length)) {
        return NO;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",telStr]]] == YES) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",telStr]]];
        return YES;
    }
    return NO;
}
+ (BOOL)isUserNameWith:(NSString *)str{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:str];
}
+ (BOOL)isPasswordWith:(NSString *)str{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:str];
}
+ (BOOL)isBankCardNumber:(NSString *)bankNumber{
    NSString * lastNum = [[bankNumber substringFromIndex:(bankNumber.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[bankNumber substringToIndex:(bankNumber.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    __block NSInteger sumEvenNumTotal = 0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    NSInteger lastNumber = [lastNum integerValue];
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    return (luhmTotal%10 ==0)?YES:NO;
}
+ (BOOL)isFloatPointNumbers:(NSString *)numbers{
    NSString *EM = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",EM];
    return [pred evaluateWithObject:numbers];
}

+ (BOOL)isFloatPointNumbers:(NSString *)numbers decimal:(NSUInteger)decimal{
    NSString *EM = [NSString stringWithFormat:@"^[0-9]+(\\.[0-9]{1,%zd})?$",decimal];
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",EM];
    return [pred evaluateWithObject:numbers];
}
@end
