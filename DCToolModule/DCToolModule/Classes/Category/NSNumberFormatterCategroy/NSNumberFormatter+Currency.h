//
//  NSNumberFormatter+Currency.h
//  Shake
//
//  Created by liumingkui on 14-8-12.
//  Copyright (c) 2014年 ___PURANG___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter(Currency)

// 小数点后保持2位 每3位一个分割符""
- (void)numberFormatterCurrencyStyle;

// 取整，没3位一个分隔符""
- (void)numberFormatterPurchaseStyle;

@end
