//
//  UIButton+Indicator.h
//  LBIndicatorItem
//
//  Created by 王祥伟 on 2018/3/5.
//  Copyright © 2018年 LittleBitch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XWIndicatorState) {
    XWIndicatorStateLoading = 0,
    XWIndicatorStateStop,
};

@interface UIButton (Indicator)

#pragma mark - Indicator

@property (null_resettable, nonatomic, strong) UIColor *indicatorColor;

/**
 设置按钮文字

 @param title 文字
 @param state 状态
 */
- (void)setTitle:(nullable NSString *)title forIndicatorState:(XWIndicatorState)state;

/**
 设置titlecolor

 @param color 颜色
 @param state 状态
 */
- (void)setTitleColor:(nullable UIColor *)color forIndicatorState:(XWIndicatorState)state;

/**
 设置button  image

 @param image image
 @param state 状态
 */
- (void)setImage:(nullable UIImage *)image forIndicatorState:(XWIndicatorState)state;

/**
 设置按钮背景图片

 @param image 图片
 @param state 状态
 */
- (void)setBackgroundImage:(nullable UIImage *)image forIndicatorState:(XWIndicatorState)state;

/**
 开始loading
 */
- (void)indicatorStateLoading;

/**
 结束loading
 */
- (void)indicatorStateStop;

/**
 是否在loading中

 @return result
 */
- (BOOL)isIndicatorLoading;

#pragma mark - 倒计时

/*
 *    倒计时按钮
 *    @param timeLine  倒计时总时间
 *    @param title     还没倒计时的title
 *    @param subTitle  倒计时的子名字 如：时、分
 *    @param mColor    还没倒计时的颜色
 *    @param color     倒计时的颜色
 */

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

@end
