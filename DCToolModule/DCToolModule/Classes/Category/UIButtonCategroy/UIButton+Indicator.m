//
//  UIButton+Indicator.m
//  LBIndicatorItem
//
//  Created by 王祥伟 on 2018/3/5.
//  Copyright © 2018年 LittleBitch. All rights reserved.
//

#import "UIButton+Indicator.h"
#import <objc/runtime.h>

static char indicatorColorKey;
static char titleLoadingKey;
static char titleStopKey;
static char colorLoadingKey;
static char colorStopKey;
static char imageLoadingKey;
static char imageStopKey;
static char backgroundImageLoadingKey;
static char backgroundImageStopKey;

@implementation UIButton (Indicator)

@dynamic indicatorColor;

#pragma mark - Getters (Public)
- (void)indicatorStateLoading{
    [self setIndicatorLoading];
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
    indicatorView.center = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds));
    UIColor *indicatorColor = objc_getAssociatedObject(self, &indicatorColorKey);
    indicatorView.color = indicatorColor;
    [self addSubview:indicatorView];
    [indicatorView startAnimating];
}

- (void)indicatorStateStop{
    if ([self isIndicatorLoading]) {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[UIActivityIndicatorView class]]) {
                [self setIndicatorStop];
                UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)subView;
                [indicatorView stopAnimating];
                [indicatorView removeFromSuperview];
                break;
            }
        }
    }
}

- (BOOL)isIndicatorLoading{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIActivityIndicatorView class]]) {
            UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)subView;
            if ([indicatorView isAnimating]) {
                return YES;
            }
            break;
        }
    }
    return NO;
}

- (void)setTitle:(nullable NSString *)title forIndicatorState:(XWIndicatorState)state{
    if (state == XWIndicatorStateLoading) {
        objc_setAssociatedObject(self, &titleLoadingKey, title, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else if (state == XWIndicatorStateStop){
        objc_setAssociatedObject(self, &titleStopKey, title, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setTitleColor:(nullable UIColor *)color forIndicatorState:(XWIndicatorState)state{
    if (state == XWIndicatorStateLoading) {
        objc_setAssociatedObject(self, &colorLoadingKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else if (state == XWIndicatorStateStop){
        objc_setAssociatedObject(self, &colorStopKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setImage:(UIImage *)image forIndicatorState:(XWIndicatorState)state{
    if (state == XWIndicatorStateLoading) {
        objc_setAssociatedObject(self, &imageLoadingKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else if (state == XWIndicatorStateStop){
        objc_setAssociatedObject(self, &imageStopKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setBackgroundImage:(nullable UIImage *)image forIndicatorState:(XWIndicatorState)state{
    if (state == XWIndicatorStateLoading) {
        objc_setAssociatedObject(self, &backgroundImageLoadingKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else if (state == XWIndicatorStateStop){
        objc_setAssociatedObject(self, &backgroundImageStopKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setIndicatorColor:(UIColor *)indicatorColor{
    objc_setAssociatedObject(self, &indicatorColorKey, indicatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Getters (Private)

- (void)setIndicatorLoading{
    NSString *title = objc_getAssociatedObject(self, &titleLoadingKey);
    UIColor *color = objc_getAssociatedObject(self, &colorLoadingKey);
    UIImage *image = objc_getAssociatedObject(self, &imageLoadingKey);
    UIImage *backgroundImage = objc_getAssociatedObject(self, &backgroundImageLoadingKey);
    if (title) [self setTitle:title forState:0];
    if (color) [self setTitleColor:color forState:0];
    if (image) [self setImage:image forState:0];
    if (backgroundImage) [self setBackgroundImage:backgroundImage forState:0];
}

- (void)setIndicatorStop{
    NSString *title = objc_getAssociatedObject(self, &titleStopKey);
    UIColor *color = objc_getAssociatedObject(self, &colorStopKey);
    UIImage *image = objc_getAssociatedObject(self, &imageStopKey);
    UIImage *backgroundImage = objc_getAssociatedObject(self, &backgroundImageStopKey);
    if (title) [self setTitle:title forState:self.state];
    if (color) [self setTitleColor:color forState:self.state];
    if (image) [self setImage:image forState:self.state];
    if (backgroundImage) [self setBackgroundImage:backgroundImage forState:self.state];
}

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color{
    
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}

@end
