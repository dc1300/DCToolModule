//
//  PRSystemConfig.h
//  Pods
//
//  Created by wanglei on 2019/4/12.
//

#ifndef PRSystemConfig_h
#define PRSystemConfig_h

///App名称
#define __kAppName__ [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
///bundle号
#define __kBundleId__ [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
///版本号
#define __kVersion__  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
///手机系统版本
#define __kSystemVersion__ [[[UIDevice currentDevice] systemVersion] floatValue]

#define __kUserDefaults__       [NSUserDefaults standardUserDefaults]
#define __kNotificationCenter__ [NSNotificationCenter defaultCenter]
///发送通知
#define __kPostNotification(name,obj) [__kNotificationCenter__ postNotificationName:name object:obj];

///判断是否是ios9
#define IOS9_OR_LATER (__kSystemVersion__ >= 9.0)
///判断是否是ios10
#define IOS10_OR_LATER (__kSystemVersion__ >= 10.0)
///判断是否是ios11
#define IOS11_OR_LATER (__kSystemVersion__ >= 11.0)
///判断是否是ios12
#define IOS12_OR_LATER (__kSystemVersion__ >= 12.0)


#define __kWeakSelf__        __weak typeof(self) weakSelf = self;
#define __kStrongSelf__      __strong typeof(weakSelf) strongSelf = weakSelf;
#define __kWeakSelf(type)    __weak typeof(type) weak##type = type;
#define __kStrongSelf(type)  __strong typeof(type) type = weak##type;


#define __kFormat(string)    [NSString stringWithFormat:@"%@",string]


///获取Image
#define IMG(NAME) [UIImage imageNamed:(NAME)]
#define OrigIMG(a) [IMG(a) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

///获得SB的vc  SB的name和vc的id
#define SBVC(name,vcId) [[UIStoryboard storyboardWithName:name bundle:[NSBundle bundleForClass:[self class]]] instantiateViewControllerWithIdentifier:vcId];



#define __kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || [str isEqualToString:@"NULL"] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str length] < 1 ? YES : NO )

static inline BOOL IsEmpty(id thing) {
    return thing == nil || [thing isEqual:[NSNull null]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#if DEBUG
#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

#warning 待移除(不推荐使用)
//*************************待移除(不推荐使用)**************************************//


#define PFVAPP_VERSION __kVersion__
#define kSystemVersion [[UIDevice currentDevice] systemVersion]

#define WEAKSELF    __kWeakSelf__
#define STRONGSELF  __kStrongSelf__

#define Format(string) __kFormat(string)

#define kStringIsEmpty(str) __kStringIsEmpty(str)

#define SYSTEMFONT(FONTSIZE)    __kFont(FONTSIZE)

#endif /* PRSystemConfig_h */
