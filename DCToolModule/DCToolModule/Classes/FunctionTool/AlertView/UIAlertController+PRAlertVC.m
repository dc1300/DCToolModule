//
//  UIAlertController+PRAlertVC.m
//  AFNetworking
//
//  Created by daichen on 2018/9/19.
//

#import "UIAlertController+PRAlertVC.h"

@implementation UIAlertController (PRAlertVC)
- (void)setUpTitleAlignment:(NSTextAlignment)titleAlignment messageAlignment:(NSTextAlignment)messageAlignment{
    if ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 12) {
        //创建可变NSMutableParagraphStyle
        NSMutableParagraphStyle *messageParagraphStyle = [[NSMutableParagraphStyle alloc]init];
        messageParagraphStyle.alignment = messageAlignment;
        NSMutableAttributedString * attrMessage = [[NSMutableAttributedString alloc]initWithString:self.message.length == 0?@"":self.message attributes:@{NSParagraphStyleAttributeName:messageParagraphStyle}];
        //设置attributedMessage属性
        [self setValue:attrMessage forKey:@"attributedMessage"];
        //创建可变NSMutableParagraphStyle
        NSMutableParagraphStyle *titleParagraphStyle = [[NSMutableParagraphStyle alloc]init];
        titleParagraphStyle.alignment = titleAlignment;
        NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc]initWithString:self.title.length == 0?@"":self.title attributes:@{NSParagraphStyleAttributeName:titleParagraphStyle}];
        //设置attributedMessage属性
        [self setValue:attrTitle forKey:@"attributedTitle"];
    }else{
        UIView *subView1 = self.view.subviews[0];
        UIView *subView2 = subView1.subviews[0];
        UIView *subView3 = subView2.subviews[0];
        UIView *subView4 = subView3.subviews[0];
        UIView *subView5 = subView4.subviews[0];
        UILabel *titleLabel;
        UILabel *msgLabel;
        if(self.title.length == 0){
            msgLabel = subView5.subviews[0];
        }else{
            titleLabel = subView5.subviews[0];
            msgLabel = subView5.subviews[1];
        }
        titleLabel.textAlignment = titleAlignment;
        msgLabel.textAlignment = messageAlignment;
    }
}
@end
