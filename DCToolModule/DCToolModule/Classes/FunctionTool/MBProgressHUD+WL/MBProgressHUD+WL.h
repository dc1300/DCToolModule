//
//  MBProgressHUD+WL.h
//  MBProgressHUD+WL
//
//  Created by WL on 2018/5/14.
//
//  pod 'MBProgressHUD', '~> 1.1.0'

#import "MBProgressHUD.h"

@interface MBProgressHUD (WL)


+ (MBProgressHUD *)showText:(NSString *)text;
+ (MBProgressHUD *)showText:(NSString *)text toView:(UIView *)view;


+ (MBProgressHUD *)showSuccess:(NSString *)success;
+ (MBProgressHUD *)showSuccess:(NSString *)success toView:(UIView *)view;


+ (MBProgressHUD *)showError:(NSString *)error;
+ (MBProgressHUD *)showError:(NSString *)error toView:(UIView *)view;


+ (MBProgressHUD *)showText:(NSString *)text icon:(UIImage *)icon toView:(UIView *)view;


+ (MBProgressHUD *)showHUD;
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (BOOL)hideHUDForView:(UIView *)view;
+ (BOOL)hideHUD;



@end
