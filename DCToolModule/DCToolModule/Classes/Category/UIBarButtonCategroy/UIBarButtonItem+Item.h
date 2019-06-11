//
//  UIBarButtonItem+Item.h
//  传智微博
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+EdgeInsets.h"
@interface UIBarButtonItem (Item)

/**
 创建uibutton 做barbuttonitem

 @param image button image
 @param highImage heightlightImage
 @param target target
 @param action action
 @param controlEvents event
 @return barbuttonitem
 */
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 创建uibutton 做barbuttonitem

 @param title button title
 @param target target
 @param action action
 @param controlEvents controlEvents
 @return barbuttonitem
 */
+ (UIBarButtonItem *)rightbarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 创建uibutton 做barbuttonitem

 @param title title
 @param image image
 @param target target
 @param action action
 @param controlEvents controlEvents
 @return barbuttonitem
 */
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title Image:(UIImage *)image target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;


/**
 创建uibutton 做barbuttonitem

 @param image image
 @param highImage highImage
 @param target target
 @param action action
 @param controlEvents controlEvents
 @return barbuttonitem
 */
+ (UIBarButtonItem *)rightbarButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 创建uibutton 做barbuttonitem

 @param title title
 @param image image
 @param color titlecolor
 @param font titlefont
 @param type 图片和文字的位置
 @param spacing 图片和文字之间的距离
 @param target target
 @param action action
 @param controlEvents controlEvents
 @return barbuttonitem
 */
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title Image:(UIImage *)image Color:(UIColor *)color Font:(UIFont *)font Type:(XWImagePositionType)type spacing:(CGFloat)spacing target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
