//
//  NSString+Judge.h
//  MBProgressHUD
//
//  Created by zhoujunchun on 2019/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Judge)

/**
 检验是否 是邮箱格式
 */
+ (BOOL)checkEmailInputWith:(NSString *)str;
/**
 验证身份证信息
 */
+ (BOOL)checkIdentityCardWith:(NSString *)str;

/**
 是否是空字符串
 */
+ (BOOL)isBlankStringWith:(id)str;

/***
 是否是 空字符串
 */
+ (BOOL)isNotEmptyWith:(NSString *)str;

/**
 校验字符串是否纯数字
 */
+ (BOOL)numInputShouldNumberWith:(NSString *)str;

/**
 判断数组转成的字符串A中是否包含字符串B
 */
+ (BOOL)bigString:(NSString *)bigString containString:(NSString *)string;

/**
 校验输入的是否是电话
 */
+ (BOOL)checkPhoneNumInputWith:(NSString *)str;

/**
 校验是否包含手机号
 */
+ (BOOL)isContainPhoneWith:(NSString *)str;

/**
 是否包含字符串 不区分大小写
 */
- (BOOL)containsString:(NSString *)string;

/**
 是否包含字符串 option表示策略
 */
- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options;

/**
 校验是否可以拨电话
 */
+ (BOOL)canTelWith:(NSString *)str;

/**
 *  正则匹配用户姓名,20位的中文或英文
 */
+ (BOOL)isUserNameWith:(NSString *)str;

/**
 *  正则匹配用户密码6-18位数字和字母组合
 */
+ (BOOL)isPasswordWith:(NSString *)str;
/**
 *  正则匹配银行卡号
 */
+ (BOOL)isBankCardNumber:(NSString *)bankNumber;
/**
 *  正则匹配2位小数
 */
+ (BOOL)isFloatPointNumbers:(NSString *)numbers;

/**
 *  正则匹配 对小数位进行判断
 *
 *  @param decimal 小数类型
 */
+ (BOOL)isFloatPointNumbers:(NSString *)numbers decimal:(NSUInteger)decimal;


@end

NS_ASSUME_NONNULL_END
