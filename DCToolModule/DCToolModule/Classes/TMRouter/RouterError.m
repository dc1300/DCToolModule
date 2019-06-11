//
//  RouterError.m
//  MTRouterDemo
//
//  Created by 董徐维 on 2018/2/1.
//  Copyright © 2018年 董徐维. All rights reserved.
//

#import "RouterError.h"
#import "TMRouter.h"
@implementation RouterError

+(id)sharedInstance
{
    static dispatch_once_t onceToken;
    static RouterError * routerError;
    dispatch_once(&onceToken,^{
        routerError = [[RouterError alloc] init];
    });
    return routerError;
}

#pragma mark  自定义错误页面 此页面一定确保能够找到，否则会进入死循环
-(UIViewController *)getErrorController{
    NSDictionary *diction = [[NSMutableDictionary alloc] init];
    [diction setValue:@"https://github.com/MrTung/MTRouter.git" forKey:@"url"];
    UIViewController *errorController = [[TMRouter sharedInstance] getViewController:@"PRRouteSchemeController://isNav=false&native=true&name=RouterErrorViewController" withParam:diction];
    return errorController;
}

-(id)getErrorNSobjectWith:(NSDictionary *)dataDic
{
    return [[TMRouter sharedInstance] getViewController:@"PRRouteSchemeNSObject://name=RouterErrorObject" withParam:dataDic];
}
@end
