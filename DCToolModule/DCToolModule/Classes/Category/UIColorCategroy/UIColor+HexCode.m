//
//  UIColor+HexCode.m
//  Shake
//
//  Created by liumingkui on 14-8-11.
//  Copyright (c) 2014年 ___PURANG___. All rights reserved.
//

#import "UIColor+HexCode.h"

@implementation UIColor(HexCode)

+ (UIColor *)colorFromHexCode:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3)
    {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    
    if([cleanString length] == 6)
    {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    CGFloat red = ((baseValue >> 24) & 0xFF)/255.0f;
    CGFloat green = ((baseValue >> 16) & 0xFF)/255.0f;
    CGFloat blue = ((baseValue >> 8) & 0xFF)/255.0f;
    CGFloat alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CAGradientLayer *)colorArray:(NSArray *)colorArray frame:(CGRect)frame
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    gradient.colors = colorArray;
    return gradient;
}

- (NSDictionary *)getRGBDictionaryByColor{
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    r = r * 255;
    g = g * 255;
    b = b * 255;
    
    return @{@"R":@(r),
             @"G":@(g),
             @"B":@(b),
             @"A":@(a)};
}

- (CGFloat)red{
    NSDictionary * dict = [self getRGBDictionaryByColor];
    return [dict[@"R"] floatValue];
}

- (CGFloat)green{
    NSDictionary * dict = [self getRGBDictionaryByColor];
    return [dict[@"G"] floatValue];
}

- (CGFloat)blue{
    NSDictionary * dict = [self getRGBDictionaryByColor];
    return [dict[@"B"] floatValue];
}

- (CGFloat)alpha{
    NSDictionary * dict = [self getRGBDictionaryByColor];
    return [dict[@"A"] floatValue];
}

@end
