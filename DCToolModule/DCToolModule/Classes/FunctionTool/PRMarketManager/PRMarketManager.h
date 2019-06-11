//
//  PRMarketManager.h
//  PRBaseDependTool
//
//  Created by wanglei on 2019/4/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PRMarketSizeType) {
    PRMarketSizeTypeFive,
    PRMarketSizeTypeSix,
    PRMarketSizeTypePlus,
    PRMarketSizeTypeX,
    PRMarketSizeTypeXR,
    PRMarketSizeTypeXMax
};


@interface PRMarketManager : NSObject

+ (PRMarketManager *)sharedPRMarketManager;

- (CGFloat)translationSize:(CGFloat)pxSize;

- (CGFloat)translationSize:(CGFloat)pxSize marketSizeType:(PRMarketSizeType)marketSizeType;

- (NSString *)getCurrentDevice;

+ (BOOL)isIPhoneXType;

+ (CGFloat)safeAreaInsetsBottom;

@end

