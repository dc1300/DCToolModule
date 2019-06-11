//
//  MBProgressHUD+WL.m
//  MBProgressHUD+WL
//
//  Created by WL on 2018/5/14.
//

#import "MBProgressHUD+WL.h"

@implementation MBProgressHUD (WL)


+ (MBProgressHUD *)showText:(NSString *)text{
    return [self showText:text toView:nil];
}
+ (MBProgressHUD *)showText:(NSString *)text toView:(UIView *)view{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    
    hud.label.text = text;
    
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    
//    //遮挡
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.backgroundView.color =  [UIColor colorWithWhite:0.f alpha:.2f];
    
    hud.removeFromSuperViewOnHide = YES;
    double delayTime = 1.2;
    delayTime = MAX(delayTime, text.length*0.3);
    delayTime = MIN(delayTime, 2.5);
    [hud hideAnimated:YES afterDelay:delayTime];
    return hud;
}


+ (MBProgressHUD *)showSuccess:(NSString *)success{
    return [self showSuccess:success toView:nil];
}
+ (MBProgressHUD *)showSuccess:(NSString *)success toView:(UIView *)view{
   
    NSString *fwPath = [[[NSBundle mainBundle] privateFrameworksPath] stringByAppendingPathComponent:@"PRBaseDependTool.framework"];
    NSBundle *bundle = [NSBundle bundleWithPath:fwPath];
    NSString *path = [bundle pathForResource:@"MBProgressHUD" ofType:@"bundle"];
    bundle = [NSBundle bundleWithPath:path];
    NSString *imagePath = [bundle pathForResource:@"success@2x" ofType:@"png"];
    
    UIImage *image = [[UIImage imageWithContentsOfFile:imagePath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return [self showText:success icon:image toView:view];
}


+ (MBProgressHUD *)showError:(NSString *)error{
    return [self showError:error toView:nil];
}
+ (MBProgressHUD *)showError:(NSString *)error toView:(UIView *)view{
    
    NSString *fwPath = [[[NSBundle mainBundle] privateFrameworksPath] stringByAppendingPathComponent:@"PRBaseDependTool.framework"];
    NSBundle *bundle = [NSBundle bundleWithPath:fwPath];
    NSString *path = [bundle pathForResource:@"MBProgressHUD" ofType:@"bundle"];
    bundle = [NSBundle bundleWithPath:path];
    NSString *imagePath = [bundle pathForResource:@"error@2x" ofType:@"png"];
    
    UIImage *image = [[UIImage imageWithContentsOfFile:imagePath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return [self showText:error icon:image toView:view];
}


+ (MBProgressHUD *)showText:(NSString *)text icon:(UIImage *)icon toView:(UIView *)view{
    
    if (!icon) {
        //图片不存在情况，特殊处理
        return [self showText:text toView:view];
    }
    
    
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.customView = [[UIImageView alloc] initWithImage:[icon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    hud.square = YES;
 
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    
    hud.detailsLabel.textColor = [UIColor whiteColor];
    
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];

    
//    //遮挡
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.backgroundView.color =  [UIColor colorWithWhite:0.f alpha:.2f];
    
    hud.removeFromSuperViewOnHide = YES;
    double delayTime = 1.2;
    delayTime = MAX(delayTime, text.length*0.3);
    delayTime = MIN(delayTime, 2.5);
    [hud hideAnimated:YES afterDelay:delayTime];
    return hud;
}


+ (MBProgressHUD *)showHUD{
    return [self showMessage:nil];
}
+ (MBProgressHUD *)showMessage:(NSString *)message{
    return [self showMessage:message toView:nil];
}
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.square = YES;
    hud.label.text = message;
    
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    
    
    hud.removeFromSuperViewOnHide = YES;
    
//    //遮挡
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.backgroundView.color =  [UIColor colorWithWhite:0.f alpha:.2f];
    
    return hud;
}


+ (BOOL)hideHUDForView:(UIView *)view{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    return [self hideHUDForView:view animated:YES];
}
+ (BOOL)hideHUD{
    return [self hideHUDForView:nil];
}


@end
