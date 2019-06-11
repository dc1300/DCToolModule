//
//  PFVLoginStatue.h
//  PurangFinanceVillage
//
//  Created by zhoujunchun on 2018/5/24.
//  Copyright © 2018年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

//直接跳转
static NSString *const NEED_PUSH_LOGIN_NOTIFICATION = @"NEED_PUSH_LOGIN_NOTIFICATION";
//带提醒框
static NSString *const NEED_ALERT_LOGIN_NOTIFICATION = @"NEED_ALERT_LOGIN_NOTIFICATION";


///判断是否登录
#define __isLogin__             [[PFVLoginStatue sharedInstance] isLogin]
///跳转登录页面
#define __isLoginWithPush__     [[PFVLoginStatue sharedInstance] checkLoginWithPushIfNeed]
///弹出登录提醒弹窗
#define __isLoginWithAlert__    [[PFVLoginStatue sharedInstance] checkLoginWithAlertIfNeed]


@interface PFVLoginStatue : NSObject

@property (nonatomic, assign) BOOL isLogin;

+ (instancetype)sharedInstance;

- (BOOL)checkLoginWithPushIfNeed;

- (BOOL)checkLoginWithAlertIfNeed;

@end
