//
//  NSAttributedString+Extensions.h
//  product
//
//  Created by wangxiangwei on 2017/11/24.
//  Copyright © 2017年 purang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (Extensions)


/*
 *    富文本
 *    @param textArray  内容 文字、图片
 *    @param colorArray color数组， 取对应值，默认whiteColor
 *    @param sizeArray  大小，可以是NSNumber，UIFont
 *
 */
+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray;

/*
 *    富文本
 *    @param textArray  内容 文字、图片
 *    @param colorArray color数组， 取对应值，默认whiteColor
 *    @param sizeArray  大小，可以是NSNumber，UIFont
 *    @param offset     NSBaselineOffsetAttributeName
 *
 */
+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray baselineOffset:(NSNumber *)offset;

/*
 *    富文本
 *    @param textArray  内容 文字、图片
 *    @param colorArray color数组， 取对应值，默认whiteColor
 *    @param sizeArray  大小，可以是NSNumber，UIFont
 *    @param keyArray   其他属性值
 *
 */
+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray keyArray:(NSArray *)keyArray;

/**
 *fontSize 数字文字大小
 *fontSize2 小数点后文字大小
 *fontSize3 整段文字大小
 */
- (NSAttributedString *)getAttributedStringFontSize1:(CGFloat)fontSize fontSize2:(CGFloat)fontSize2 fontSize3:(CGFloat)fontSize3 Color:(UIColor *)Color1 Color2:(UIColor *)Color2 Color3:(UIColor *)Color3 text:(NSString *)text;


/** 一段文字部分变色/大小
 *str1 要变色的文字
 *fontSize 整体文字大小
 *fontSize1 变色文字大小
 */
- (NSAttributedString *)getAttributedString:(NSString *)str1 FontSize1:(CGFloat)fontSize fontSize1:(CGFloat)fontSize1  Color:(UIColor *)Color Color1:(UIColor *)Color1 text:(NSString *)text;

@end
