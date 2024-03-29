//
//  XWAlertViewController.m
//  XWEncapsulation
//
//  Created by wangxiangwei on 17/3/16.
//  Copyright © 2017年 purang. All rights reserved.
//

#import "XWAlertViewController.h"
#import "PRBaseHeader.h"
#import "UIAlertController+PRAlertVC.h"

@implementation XWAlertViewController
+ (void)alertControllerWithTitle:(NSString *)title message:(NSString *)message{
    [self alertControllerInVC:nil title:title message:message];
}

+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message{
    [self alertControllerInVC:vc title:title message:message cancelTitle:nil];
}

+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle{
    [self alertControllerInVC:vc title:title message:message cancelTitle:cancelTitle cancel:nil];
}

+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancelBlock{
    [self alertControllerInVC:vc title:title message:message cancelTitle:cancelTitle cancel:cancelBlock sureTitle:nil sure:nil];
}

+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancelBlock sureTitle:(NSString *)sureTitle sure:(sureBlock)sureBlock{
    
    
    [self alertControllerInVC:vc title:title message:message cancelTitle:cancelTitle cancel:cancelBlock otherTitle:sureTitle?[NSArray arrayWithObject:sureTitle]:nil sure:sureBlock];
}

+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock) cancelBlock otherTitle:(NSArray <NSString *>*)otherTitle sure:(sureBlock)sureBlock{
    [self alertControllerInVC:vc style:UIAlertControllerStyleAlert title:title message:message cancelTitle:cancelTitle cancel:cancelBlock otherTitle:otherTitle sure:sureBlock];
}

+ (void)alertControllerInVC:(UIViewController *)vc style:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock) cancelBlock otherTitle:(NSArray <NSString *>*)otherTitle sure:(sureBlock)sureBlock{
    if (!cancelTitle) cancelTitle = @"确定";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock(action.title);
        }
    }]];
    for (int i = 0; i < otherTitle.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:otherTitle[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                NSLog(@"%d %@",i,action.title);
                sureBlock(action.title);
            }
        }]];
    }
    if (vc) {
        [vc presentViewController:alert animated:YES completion:nil];
    }else{
        [[self getTopViewController] presentViewController:alert animated:YES completion:nil];
    }
}

+ (void)idSurealertControllerInVC:(UIViewController *)vc style:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock) cancelBlock otherTitle:(NSArray <NSString *>*)otherTitle sure:(IDsureBlock)sureBlock{
    if (!cancelTitle) cancelTitle = @"确定";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock(action.title);
        }
    }]];
    for (int i = 0; i < otherTitle.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:otherTitle[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                NSLog(@"%d %@",i,action.title);
                sureBlock(i,action.title);
            }
        }]];
    }
    if (vc) {
        [vc presentViewController:alert animated:YES completion:nil];
    }else{
        [[self getTopViewController] presentViewController:alert animated:YES completion:nil];
    }
}

+ (void)alertControllerInVC:(UIViewController *)vc style:(UIAlertControllerStyle)style title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock) cancelBlock otherTitle:(NSArray <NSString *>*)otherTitle complete:(sureBlock)completeBlock {
    if (!cancelTitle) cancelTitle = @"确定";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock(action.title);
        }
    }]];
    for (int i = 0; i < otherTitle.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:otherTitle[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completeBlock) {
                NSLog(@"%d %@",i,action.title);
                completeBlock(@{@"index" : @(i), @"title" : action.title});
            }
        }]];
    }
    if (vc) {
        [vc presentViewController:alert animated:YES completion:nil];
    }else{
        [[self getTopViewController] presentViewController:alert animated:YES completion:nil];
    }
}


+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message titleAlignment:(NSTextAlignment)titleAlignment messageAlignment:(NSTextAlignment)messageAlignment cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancelBlock sureTitle:(NSString *)sureTitle sure:(sureBlock)sureBlock{
    if (IsEmpty(title)) {
        title = @"";
    }
    if (!cancelTitle) cancelTitle = @"确定";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert setUpTitleAlignment:titleAlignment messageAlignment:messageAlignment];
    if (!IsEmpty(cancelTitle)) {
        [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock(action.title);
            }
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureBlock) {
            sureBlock(action.title);
        }
    }]];
    if (vc) {
        [vc presentViewController:alert animated:YES completion:nil];
    }else{
        [[self getTopViewController] presentViewController:alert animated:YES completion:nil];
    }
}


+ (void)alertControllerInVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message textAlignment:(NSTextAlignment)textAlignment cancelTitle:(NSString *)cancelTitle cancel:(cancelBlock)cancelBlock sureTitle:(NSString *)sureTitle sure:(sureBlock)sureBlock{
    if (IsEmpty(title)) {
        title = @"";
    }
    if (!cancelTitle) cancelTitle = @"确定";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert setUpTitleAlignment:NSTextAlignmentCenter messageAlignment:textAlignment];
    if (!IsEmpty(cancelTitle)) {
        [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock(action.title);
            }
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureBlock) {
            sureBlock(action.title);
        }
    }]];
    if (vc) {
        [vc presentViewController:alert animated:YES completion:nil];
    }else{
        [[self getTopViewController] presentViewController:alert animated:YES completion:nil];
    }
}


+ (UIViewController *)getTopViewController{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *vc = window.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        if ([vc isKindOfClass:[UIAlertController class]]) {
            vc = vc.parentViewController;
        }
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = [(UITabBarController *)vc selectedViewController];
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController *)vc topViewController];
    }
    return vc;
}

@end

