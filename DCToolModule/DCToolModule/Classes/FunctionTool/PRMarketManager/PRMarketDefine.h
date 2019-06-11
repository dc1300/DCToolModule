//
//  PRMarketDefine.h
//  PRBaseDependTool_Example
//
//  Created by wanglei on 2019/5/28.
//  Copyright © 2019 PurangTechnology. All rights reserved.
//

#ifndef PRMarketDefine_h
#define PRMarketDefine_h
#import "PRMarketManager.h"

#pragma mark - configuration(配置)

///默认的UI设计尺寸
#define PRDefuleDesignWidth  PRMarketSizeTypeSix

#define __kIsVertical__  ([[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height)

//各个机型默认宽度大小
#define PRDefule40InchScreenWidth     (__kIsVertical__?320.0:568.0)
#define PRDefule47InchScreenWidth     (__kIsVertical__?375.0:667.0)
#define PRDefule55InchScreenWidth     (__kIsVertical__?414.0:736.0)
#define PRDefule58InchScreenWidth     (__kIsVertical__?375.0:812.0)
#define PRDefule61InchScreenWidth     (__kIsVertical__?414.0:896.0)
#define PRDefule65InchScreenWidth     (__kIsVertical__?414.0:896.0)


#pragma mark - 传入一个px尺寸  输出一个按照屏幕适配的尺寸(默认尺寸)

#define __kNewSize(pxSize) [[PRMarketManager sharedPRMarketManager] translationSize:pxSize]

#define __kNewCGSizeMake(pxWidth,pxHeight) CGSizeMake(__kNewSize(pxWidth), __kNewSize(pxHeight))

#define __kNewCGRectMake(pxX,pxY,pxWidth,pxHeight) CGRectMake(__kNewSize(pxX), __kNewSize(pxY), __kNewSize(pxWidth), __kNewSize(pxHeight))

#define __kNewFont(pxSize) [UIFont systemFontOfSize:__kNewSize(pxSize)]

#define __kNewBoldFont(pxSize) [UIFont boldSystemFontOfSize:__kNewSize(pxSize)]



#pragma mark - 传入一个pt尺寸  输出一个按照屏幕适配的尺寸(默认尺寸)

#define __kSize(ptSize) [[PRMarketManager sharedPRMarketManager] translationSize:(ptSize*2.0)]

#define __kCGSizeMake(ptWidth,ptHeight) CGSizeMake(__kSize(ptWidth), __kSize(ptHeight))

#define __kCGRectMake(ptX,ptY,ptWidth,ptHeight) CGRectMake(__kSize(ptX), __kSize(ptY), __kSize(ptWidth), __kSize(ptHeight))

#define __kFont(ptSize) [UIFont systemFontOfSize:__kSize(ptSize)]

#define __kBoldFont(ptSize) [UIFont boldSystemFontOfSize:__kSize(ptSize)]

#endif /* PRMarketDefine_h */
