//
//  RouterErrorObject.m
//  MTRouterDemo
//
//  Created by zhoujunchun on 2018/7/12.
//  Copyright © 2018年 董徐维. All rights reserved.
//

#import "RouterErrorObject.h"

@interface RouterErrorObject ()
{
    void (^block)(NSDictionary *msg);
}

@end
@implementation RouterErrorObject

-(void)initViewControllerParam:(NSDictionary *)dic
{
    NSLog(@"------->%@",dic);
    block = [dic[@"RouterBlock"] copy];
    block(@{@"errror":@"未找到相应的类",@"success":@"false"});
}


- (void)dealloc{
   NSLog(@"------->释放");
}


@end
