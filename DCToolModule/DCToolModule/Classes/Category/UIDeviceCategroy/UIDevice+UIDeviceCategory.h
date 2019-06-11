//
//  UIDevice+UIDeviceCategory.h
//  格桑梅朵
//
//  Created by liumingkui on 14-8-8.
//  Copyright (c) 2014年 ___PURANG___. All rights reserved.
//

#define SCREEN_NORMAL                0x01
#define SCREEN_RETINA                0x02

#import <UIKit/UIKit.h>

@interface UIDevice (UIDeviceCategory)


+ (CGFloat)width;
+ (CGFloat)height;

+ (NSInteger)screenType;

/**
 获取手机版本的 第一位数字

 @return 第一位数字
 */
+ (NSInteger)systemVersionFirstNumber;

/**
 是否支持

 @return Airdrop
 */
+ (BOOL)supportsAirdrop;

/**
 打印所有的字体
 */
+ (void)printAllFont;

/**
  获取当前手机系统

 @return 当前手机系统
 */
+ (CGFloat)getiOSVersion;

@end
