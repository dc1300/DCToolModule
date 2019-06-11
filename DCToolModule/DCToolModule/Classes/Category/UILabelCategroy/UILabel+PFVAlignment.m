//
//  UILabel+PFVAlignment.m
//  PurangFinanceVillage
//
//  Created by daichen on 2017/8/10.
//  Copyright © 2017年 ___PURANG___. All rights reserved.
//

#import "UILabel+PFVAlignment.h"
#import <CoreText/CoreText.h>

@implementation UILabel (PFVAlignment)

- (void)textAlignmentLeftAndRight{
    [self textAlignmentLeftAndRightWith:CGRectGetWidth(self.frame)];
}

- (void)textAlignmentLeftAndRightWith:(CGFloat)labelWidth{
    if (!self.text.length) {
        return;
    }
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(labelWidth,MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName :self.font}
                                          context:nil].size;
    NSInteger length = (self.text.length - 1);
    NSString *lastStr = [self.text substringWithRange:NSMakeRange(self.text.length-1, 1)];
    if ([lastStr isEqualToString:@":"]||[lastStr isEqualToString:@"："]) {
        length = (self.text.length - 2);
    }
    CGFloat margin = (labelWidth - size.width)/length;
    NSNumber *number = [NSNumber  numberWithFloat:margin];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString  alloc]  initWithString:self.text];
    [attribute  addAttribute:NSKernAttributeName  value:number range:NSMakeRange(0,length)];
    
    self.attributedText = attribute;
    
}

- (void)changeLineSpaceForLabelWithSpace:(float)space {
    if (!self.text.length) {
        return;
    }
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

- (void)changeWordSpaceForLabelWithSpace:(float)space {
    if (!self.text.length) {
        return;
    }
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

- (void)changeSpaceForLabelwithLineSpace:(float)lineSpace WordSpace:(float)wordSpace{
    if (!self.text.length) {
        return;
    }
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}


@end
