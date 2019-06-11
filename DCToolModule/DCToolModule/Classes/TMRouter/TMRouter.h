//
//  TMRouter.h
//  MTRouterDemo
//
//  Created by 董徐维 on 2018/2/1.
//  Copyright © 2018年 董徐维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



static NSString *const kPRRouteSchemeKey = @"PRRouteSchemeController:";
static NSString *const kPRRouteSchemeNSObjectKey = @"PRRouteSchemeNSObject:";

typedef NS_ENUM(NSInteger, TMRouterType) {
    TMRouterTypeController,//调取控制器
    TMRouterTypeNSObject//调取方法
};


@interface TMRouter : NSObject

/**
 *使用规则简要注释
 *1,pathURL定义规则
 *例如@"PRRouteSchemeController://name=PFAStoreTabbarViewController&native=true&SBName=xxxx&Identifier=xxxx"
 *双斜杠前为固定字段分别为  PRRouteSchemeController: 和  PRRouteSchemeNSObject: 分别表示查找controller及model类
 *定义model类的时候为组件使用过程中需调用其他模块方法 并且此model类必须放在主干代码中
 *查询controller，如该controller为SB创建时必须传入SBName=xxxx&Identifier=xxxx ---->native=false
 *如为非SB创建---->native=true  SBName=xxxx&Identifier=xxxx可不传
 *需要跳转的controller或者model类中须实现-(void)initViewControllerParam:(NSDictionary *)dic方法
 *2,paramdic定义规则
 *paramdic中存储相应的所需传入数据及如需要回调时需要传入的block 此block对应的key值务必为@"RouterBlock",否则可能查询不到对应的blcok方法
 */


+(id)sharedInstance;

/**
 获取控制器
 @param pathURL 控制器路径
 @return 返回控制器实例
 */
- (UIViewController *)getViewController:(NSString *)pathURL;

/**
 返回一个初始化参数之后的控制器
 @param pathURL 控制器名字
 @param paramdic 初始化参数 字典格式
 @return 控制器实例
 */
-(UIViewController *)getViewController:(NSString *)pathURL withParam:(NSDictionary *)paramdic;
@end
