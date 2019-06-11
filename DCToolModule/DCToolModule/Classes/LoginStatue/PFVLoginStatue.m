//
//  PFVLoginStatue.m
//  PurangFinanceVillage
//
//  Created by zhoujunchun on 2018/5/24.
//  Copyright © 2018年 ___PURANG___. All rights reserved.
//

#import "PFVLoginStatue.h"

@interface PFVLoginStatue()


@end

@implementation PFVLoginStatue
static dispatch_once_t onceToken;

static PFVLoginStatue *instance;
+ (instancetype)sharedInstance {
    
    dispatch_once(&onceToken, ^{
        
        instance = [[PFVLoginStatue alloc] init];
        
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (BOOL)checkLoginWithPushIfNeed{
    if (instance.isLogin) {
        return YES;
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_PUSH_LOGIN_NOTIFICATION object:nil];
        return NO;
    }
}

- (BOOL)checkLoginWithAlertIfNeed{
    if (instance.isLogin) {
        return YES;
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:NEED_ALERT_LOGIN_NOTIFICATION object:nil];
        return NO;
    }
}

@end
