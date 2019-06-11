//
//  NSString+Emoji.h
//  uitextfield
//
//  Created by zhiujunchun on 17/3/3.
//  Copyright © 2017年 PURANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)




- (BOOL)isEmoji;
- (BOOL)isIncludingEmoji ;
- (instancetype)removedEmojiString;

/**
 *  判断字符串中是否存在emoji
 */
- (BOOL)stringContainsEmoji;
- (BOOL)hasEmoji;
- (BOOL) containEmoji;

/**
 * 判断 字母、数字、中文
 */
- (BOOL)isInputRuleAndNumber;
/**
 判断是不是九宫格
 */
-(BOOL)isNineKeyBoard;

@end
