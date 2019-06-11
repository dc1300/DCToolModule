//
//  NSAttributedString+Extensions.m
//  product
//
//  Created by wangxiangwei on 2017/11/24.
//  Copyright © 2017年 purang. All rights reserved.
//

#import "NSAttributedString+Extensions.h"
#import "NSString+Judge.h"
#define defaultColor [UIColor whiteColor]
#define defaultSize  14

@implementation NSAttributedString (Extensions)

+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray{
    
    return [self attributedStringFromTextArray:textArray colorArray:colorArray sizeArray:sizeArray keyArray:nil baselineOffset:nil];
}

+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray baselineOffset:(NSNumber *)offset{
    
    return [self attributedStringFromTextArray:textArray colorArray:colorArray sizeArray:sizeArray keyArray:nil baselineOffset:offset];
}

+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray keyArray:(NSArray *)keyArray{
    
    return [self attributedStringFromTextArray:textArray colorArray:colorArray sizeArray:sizeArray keyArray:keyArray baselineOffset:nil];
}

+ (NSMutableAttributedString *)attributedStringFromTextArray:(NSArray *)textArray colorArray:(NSArray <UIColor *>*)colorArray sizeArray:(NSArray *)sizeArray keyArray:(NSArray *)keyArray baselineOffset:(NSNumber *)offset{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [textArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([textArray[idx] isKindOfClass:[UIImage class]]) {
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
            textAttachment.image = textArray[idx];
            CGFloat imgW = textAttachment.image.size.width;
            CGFloat imgH = textAttachment.image.size.height;
            
            if (!textAttachment.image) return ;
            CGSize sizeValue = CGSizeMake(imgW, imgH);
            if (sizeArray.count > idx) {
                if ([sizeArray[idx] isKindOfClass:[NSString class]]) {
                    sizeValue = CGSizeFromString(sizeArray[idx]);
                }
            }
            //居中
            CGFloat orgin_y = 0.0;
            if (imgH > sizeValue.height) {
                orgin_y = (imgH-sizeValue.height)/2;
            }
            textAttachment.bounds = CGRectMake(0.0, orgin_y, sizeValue.width, sizeValue.height);
            [attributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
        }else if ([obj isKindOfClass:[NSString class]]){
            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:obj];
            
            UIColor *colorValue = defaultColor;
            if (colorArray.count > idx) {
                if ([colorArray[idx] isKindOfClass:[UIColor class]]) {
                    colorValue = colorArray[idx];
                }
            }else{
                if ([[colorArray lastObject] isKindOfClass:[UIColor class]]) {
                    colorValue = [colorArray lastObject];
                }
            }
            
            UIFont *fontValue = [UIFont systemFontOfSize:defaultSize];
            if (sizeArray.count > idx) {
                if ([sizeArray[idx] isKindOfClass:[UIFont class]]) {
                    fontValue = sizeArray[idx];
                }else if ([sizeArray[idx] isKindOfClass:[NSNumber class]]){
                    fontValue = [UIFont systemFontOfSize:[sizeArray[idx] floatValue]];
                }
            }else{
                if ([[sizeArray lastObject] isKindOfClass:[NSNumber class]]) {
                    fontValue = [UIFont systemFontOfSize:[[sizeArray lastObject] floatValue]];
                }else if([[sizeArray lastObject] isKindOfClass:[UIFont class]]){
                    fontValue = [sizeArray lastObject];
                }
            }
            
            
            [attrString addAttributes:@{
                                        NSForegroundColorAttributeName: colorValue,
                                        NSFontAttributeName: fontValue
                                        } range:NSMakeRange(0, attrString.length)];
            
            if (keyArray) {
                if (keyArray.count > idx) {
                    id thing = keyArray[idx];
                    if ([thing isKindOfClass:[NSDictionary class]]) {
                        [attrString addAttributes:thing range:NSMakeRange(0, attrString.length)];
                    }
                }
            }
            NSString* offsetStr = [offset stringValue];
            if (![NSString isBlankStringWith:offsetStr]) {
                [attrString addAttributes:@{NSBaselineOffsetAttributeName: offset} range:NSMakeRange(0, attrString.length)];
            }
            
            [attributedString appendAttributedString:attrString];
        }
        
    }];
    return attributedString;
}

+ (NSMutableAttributedString *)getAttributeStringWithStringArray:(NSArray *)stringArray colorArray:(NSArray <UIColor *>*)colorArray fontArray:(NSArray *)fontArray{
    
    UIColor *defultColor = [UIColor whiteColor];
    UIFont  *defultFont  = [UIFont systemFontOfSize:14];
    CGFloat fontSize = 14;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    for (int i = 0;i < stringArray.count;i++) {
        
        if (colorArray.count > i) {
            defultColor = colorArray[i];
        }
        if (fontArray.count > i) {
            if ([fontArray[i] isKindOfClass:[UIFont class]]) {
                defultFont = fontArray[i];
            }else if ([fontArray[i] floatValue] > 0){
                fontSize = [fontArray[i] floatValue]-1;
                defultFont = [UIFont systemFontOfSize:[fontArray[i] floatValue]];
            }
        }
        
        if ([stringArray[i] isKindOfClass:[NSString class]]) {
            NSString *string = stringArray[i];
            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
            [attrString addAttributes:@{
                                        NSForegroundColorAttributeName: defultColor,
                                        NSFontAttributeName: defultFont
                                        } range:NSMakeRange(0, string.length)];
            [attributedString appendAttributedString:attrString];
        }else if ([stringArray[i] isKindOfClass:[UIImage class]]){
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
            textAttachment.image = stringArray[i];
            textAttachment.bounds = CGRectMake(0, 0, fontSize, fontSize);
            NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
            [attributedString appendAttributedString:imageStr];
        }
        
    }
    return attributedString;
}

- (NSAttributedString *)getAttributedStringFontSize1:(CGFloat)fontSize fontSize2:(CGFloat)fontSize2 fontSize3:(CGFloat)fontSize3 Color:(UIColor *)Color1 Color2:(UIColor *)Color2 Color3:(UIColor *)Color3 text:(NSString *)text
{
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text]];
    
    NSString *pureNumbers = [[text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789.-"] invertedSet]] componentsJoinedByString:@""];
    
    [attri addAttribute:NSForegroundColorAttributeName value:Color3 range:NSMakeRange(0, text.length)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize3] range:NSMakeRange(0, text.length)];
    
    ///数字的range
    NSRange pureNumbersRange = [text rangeOfString:pureNumbers];
    if (pureNumbersRange.location != NSNotFound) {
        [attri addAttribute:NSForegroundColorAttributeName value:Color1 range:pureNumbersRange];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:pureNumbersRange];
        ///小数点位置范围
        NSRange range1 = [pureNumbers rangeOfString:@"."];
        if (range1.location != NSNotFound) {
            ///小数点后面的数字位置范围
            NSRange range2 = NSMakeRange(pureNumbersRange.location+range1.location, pureNumbersRange.length- range1.location);
            [attri addAttribute:NSForegroundColorAttributeName value:Color2 range:range2];
            [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize2] range:range2];
        }
    }
    
    return attri;
}

- (NSAttributedString *)getAttributedString:(NSString *)str1 FontSize1:(CGFloat)fontSize fontSize1:(CGFloat)fontSize1  Color:(UIColor *)Color Color1:(UIColor *)Color1 text:(NSString *)text{
    
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text]];
    
    [attri addAttribute:NSForegroundColorAttributeName value:Color range:NSMakeRange(0, text.length)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, text.length)];
    
    NSRange range = [text rangeOfString:str1];
    if (range.location != NSNotFound) {
        [attri addAttribute:NSForegroundColorAttributeName value:Color1 range:range];
        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize1] range:range];
    }
    return attri;
}

@end
