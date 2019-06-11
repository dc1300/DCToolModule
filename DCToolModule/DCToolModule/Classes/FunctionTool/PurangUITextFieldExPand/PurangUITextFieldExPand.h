//
//  PurangUITextFieldExPand.h
//  BrightSunnySky
//
//  Created by sunhao on 2019/3/7.
//  Copyright © 2019年 PURANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurangUITextFieldExPand : UITextField
/**
 *  使用了键盘头部工具条，调整了键盘的高度
 */
@property (nonatomic, assign) BOOL adjustTextFeildH;
- (void)keyboardWillHide:(NSNotification *)notification;
//@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) NSString *placeText;

@end

