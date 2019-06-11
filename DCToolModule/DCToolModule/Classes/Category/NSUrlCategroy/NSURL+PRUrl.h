//
//  NSURL+PRUrl.h
//  BrightSunnySky
//
//  Created by wangyilu on 2017/4/26.
//  Copyright © 2017年 PURANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (PRUrl)

/**
 获取 url 拼接的参数中某个参数的具体的值

 @param key 参数名称
 @return 参数值
 */
- (NSString *)parameterForKey:(NSString *)key;


/**
 url的参数字典

 @return url的参数字典
 */
- (NSDictionary *)parameters;

@end
