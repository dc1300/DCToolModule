//
//  PRFrameConfig.h
//  PRBaseDependTool
//
//  Created by wanglei on 2019/4/12.
//

#ifndef PRFrameConfig_h
#define PRFrameConfig_h

#import "PRMarketDefine.h"

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
///屏幕分辨率（5、5S、SE）
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : 0)
///屏幕分辨率（6、6S、7、8）
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : 0)
///屏幕分辨率（6P、6SP、7P、8P）
#define iPhoneP ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : 0)
///屏幕分辨率（XR）
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : 0)
///屏幕分辨率（X、XS）
#define iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : 0)
///屏幕分辨率（XS_Max）
#define iPhoneXS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : 0)

///异形全面屏
#define iPhoneX [PRMarketManager isIPhoneXType]

//**********************************************************************************************//

///屏宽
#define __kScreenWidth__            [[UIScreen mainScreen] bounds].size.width
///屏高
#define __kScreenHeight__           [[UIScreen mainScreen] bounds].size.height
///状态栏高
#define __kStatusBarHeight__        ([UIApplication sharedApplication].statusBarFrame.size.height)
///异形屏底部安全距离
#define __kTabbarSafeBottomMargin__  [PRMarketManager safeAreaInsetsBottom]
///导航栏高（包含状态栏）
#define __kNavigationBarHeight__    (__kStatusBarHeight__ + 44.f)
///tab高度
#define __kTabBarHeight__           (49.f + __kTabbarSafeBottomMargin__)
///内容高度（去除导航栏和tab）
#define __kContentHeight__          (__kScreenHeight__-__kNavigationBarHeight__-__kTabBarHeight__)
///内容高度（去除导航栏）
#define __kOriginalHeight__         (__kScreenHeight__-__kNavigationBarHeight__)
///内容高度（去除tab）
#define __kUnitaryHeight__          (__kScreenHeight__-__kTabBarHeight__)
///tabBarFrame大小
#define __kTabBarFrame__            CGRectMake(0, __kScreenHeight__-__kTabBarHeight__, __kScreenWidth__, __kTabBarHeight__)

//**********************************************************************************************//
///View 圆角和加边框
#define __kViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

///View 圆角
#define __kViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

#define  __kAdjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

/* ********************获取frame大小********************* */
#define XOf(v)                    (v).frame.origin.x
#define YOf(v)                    (v).frame.origin.y
#define WIDTHOf(v)                (v).frame.size.width
#define HEIGHTOf(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

#warning 待移除(不推荐使用)
//*************************待移除(不推荐使用)**************************************//

#define SCREEN_WIDTH          __kScreenWidth__
#define SCREEN_HEIGHT         __kScreenHeight__
// 比例高度
#define SCREEN_HEIGHT_iPhoneX        (iPhoneX ? 667 : SCREEN_HEIGHT)
#define SCALEW(x)  ([[UIScreen mainScreen] bounds].size.width*(x)/375.0)

#define  iPhone6P               iPhoneP
#define  isIphoneX_XS           iPhoneXS
#define  isIphoneXR_XSMax       iPhoneXS_Max


#define  StatusBarHeight                  __kStatusBarHeight__
#define  NavigationBarHeight              44.f
#define  TabbarHeight                     __kTabBarHeight__
#define  TabbarSafeBottomMargin           __kTabbarSafeBottomMargin__
#define  StatusBarAndNavigationBarHeight  __kNavigationBarHeight__
#define  KStatusBottomBarHeight            (iPhoneX ? 70.f : 0.f)

#define ViewBorderRadius(View, Radius, Width, Color)  __kViewBorderRadius(View, Radius, Width, Color)
#define ViewRadius(View, Radius) __kViewRadius(View, Radius)

#define  adjustsScrollViewInsets_NO(scrollView,vc) __kAdjustsScrollViewInsets_NO(scrollView,vc)

#endif /* PRFrameConfig_h */
