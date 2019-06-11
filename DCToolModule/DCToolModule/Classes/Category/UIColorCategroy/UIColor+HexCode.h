//
//  UIColor+HexCode.h
//  Shake
//
//  Created by liumingkui on 14-8-11.
//  Copyright (c) 2014年 ___PURANG___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(HexCode)

@property (nonatomic, assign, readonly) CGFloat red;
@property (nonatomic, assign, readonly) CGFloat green;
@property (nonatomic, assign, readonly) CGFloat blue;
@property (nonatomic, assign, readonly) CGFloat alpha;

+ (UIColor *)colorFromHexCode:(NSString *)hexString;

+ (CAGradientLayer *)colorArray:(NSArray *)colorArray frame:(CGRect)frame;



@end
