//
//  PRColorConfig.h
//  Pods
//
//  Created by wanglei on 2019/4/12.
//

#ifndef PRColorConfig_h
#define PRColorConfig_h


/** RGB颜色 */
#define __kColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define __kColorAlpha(r,g,b,alp) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(alp)]

// rgb颜色转换（16进制->10进制）
#define __kColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define __kColorFromHexA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

//随机色
#define __kRandomColor__ [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1]




#warning 待移除(不推荐使用)
//*************************待移除(不推荐使用)**************************************//

#define COLORRGBA(R, G, B, A)       __kColorAlpha(R,G,B,A)
#define COLORRGB(r,g,b)             __kColor(r,g,b)


#define RGBHexAlpha(rgbValue,a)     __kColorFromHexA(rgbValue,a)
#define RGBHex(rgbValue)            __kColorFromHex(rgbValue)

#define kRandomColor                __kRandomColor__

#endif /* PRColorConfig_h */
