//
//  TMRouter.m
//  MTRouterDemo
//
//  Created by 董徐维 on 2018/2/1.
//  Copyright © 2018年 董徐维. All rights reserved.
//

#import "TMRouter.h"
#import "RouterError.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

//ignore selector unknown warning
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface TMRouter()

/**路由信息数据字典*/
@property(nonatomic,assign) TMRouterType RouterType;
@end

@implementation TMRouter

+(id)sharedInstance{
    static dispatch_once_t onceToken;
    static TMRouter * router;
    dispatch_once(&onceToken,^{
        router = [[TMRouter alloc] init];
        //初始化数据
        router.RouterType = TMRouterTypeController;
    });
    return router;
}




- (UIViewController *)getViewController:(NSString *)pathURL
{
    
    //处理字符串
    NSArray *arr1 = [pathURL componentsSeparatedByString:@"//"];
    NSString *SchemeKey = [arr1 firstObject];
    NSString *SchemeValue = [arr1 lastObject];
    
    NSArray *matchArr = [SchemeValue componentsSeparatedByString:@"&"];
    NSMutableDictionary *matchDic = [NSMutableDictionary dictionary];
    for (NSString *str in matchArr) {
        NSArray *temp = [str componentsSeparatedByString:@"="];
        [matchDic setObject:[temp lastObject] forKey:[temp firstObject]];
    }
    
    
    id instance = nil;
    NSString *class = [NSString stringWithFormat:@"%@", matchDic[@"name"]];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    
    if ([SchemeKey isEqualToString:kPRRouteSchemeKey]) {
        //控制器
        self.RouterType = TMRouterTypeController;
        if ([self isCheck:@"native" andDic:matchDic]) {
            instance = [[newClass alloc] init];
        }else{
            
            NSString *SBName = [NSString stringWithFormat:@"%@",matchDic[@"SBName"]];
            NSString *vcId = [NSString stringWithFormat:@"%@",matchDic[@"Identifier"]];
            NSString * bundleName = [NSString stringWithFormat:@"%@",matchDic[@"BundleName"]];
            if (SBName.length == 0 || vcId.length == 0) {
                return instance;
            }
            UIStoryboard* userCenterSB;
            if (bundleName.length == 0) {
                userCenterSB = [UIStoryboard storyboardWithName:SBName bundle:[NSBundle bundleForClass:[newClass class]]];
            }else{
                NSString *path = [[NSBundle bundleForClass:[newClass class]] pathForResource:bundleName ofType:@"bundle"];
                userCenterSB = [UIStoryboard storyboardWithName:SBName bundle:[NSBundle bundleWithPath:path]];
            }
            instance = [userCenterSB instantiateViewControllerWithIdentifier:vcId];
        }
        return instance;
    }else if ([SchemeKey isEqualToString:kPRRouteSchemeNSObjectKey]){
        //NSObjct
        self.RouterType = TMRouterTypeNSObject;
        instance = [[newClass alloc] init];
        return instance;
    }else{
        return instance;
    }
}

- (UIViewController *)getViewController:(NSString *)pathURL withParam:(NSDictionary *)paramdic
{
    UIViewController *controller = [self getViewController:pathURL];
    if(controller != nil){
        NSLog(@"------->%@",paramdic);
        controller = [self controller:controller withParam:paramdic andVCname:pathURL];
    }else{
        NSLog(@"未找到此类:%@",pathURL);
        //EXCEPTION  Push a Normal Error VC
        return nil;
        
//        if (self.RouterType == TMRouterTypeController) {
//            controller = [[RouterError sharedInstance] getErrorController];
//        }else{
//            controller = [[RouterError sharedInstance] getErrorNSobjectWith:paramdic];
//        }
    }
    return controller;
}

/**
 此方法用来初始化参数（控制器初始化方法默认为 initViewControllerParam。初始化方法你可以自定义，前提是VC必须实现它。要想灵活一点，也可以加一个参数actionName,当做参数传入。不过这样你就需要修改此方法了)。
 @param controller 获取到的实例VC
 @param paramdic 实例化参数
 @param vcName 控制器名字
 @return 初始化之后的VC
 */
-(UIViewController *)controller:(UIViewController *)controller withParam:(NSDictionary *)paramdic andVCname:(NSString *)vcName {
    
    SEL selector = NSSelectorFromString(@"initViewControllerParam:");
    if(![controller respondsToSelector:selector]){  //如果没定义初始化参数方法，直接返回，没必要在往下做设置参数的方法
        NSLog(@"目标类:%@未定义:%@方法",controller,@"initViewControllerParam:");
        return controller;
    }
    //在初始化参数里面添加一个key信息，方便控制器中查验路由信息
    
    NSMutableDictionary * paramdMutableDic = [NSMutableDictionary dictionaryWithDictionary:paramdic];
    
    if(paramdMutableDic == nil){
        
        [paramdMutableDic setValue:vcName forKey:@"URLKEY"];
        
        SuppressPerformSelectorLeakWarning([controller performSelector:selector withObject:paramdMutableDic]);
    }else{
        if (vcName) {
            [paramdMutableDic setValue:vcName forKey:@"URLKEY"];
        }
        
    }
    SuppressPerformSelectorLeakWarning( [controller performSelector:selector withObject:paramdMutableDic]);
    return controller;
}


- (BOOL)isCheck:(NSString *)string andDic:(NSDictionary *)dic{
    if ([dic objectForKey:string]) {
        NSString *temp = [dic objectForKey:string];
        if ([temp isEqualToString:@"true"]) {
            return YES;
        }
    }
    return NO;
}


@end
