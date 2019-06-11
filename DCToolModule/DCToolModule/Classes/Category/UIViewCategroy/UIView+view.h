//
//  UIView+view.h
//  BrightSunnySky
//
//  Created by zhoujunchun on 2018/6/27.
//  Copyright © 2018年 PURANG. All rights reserved.
//

typedef enum : NSUInteger {
    TZOscillatoryAnimationToBigger,
    TZOscillatoryAnimationToSmaller,
} TZOscillatoryAnimationType;

#import <UIKit/UIKit.h>
//#import "UIFont+PFVCommon.h"
@interface UIView (view)
@property (nonatomic, assign) CGFloat left;        ///<  frame.origin.x.
@property (nonatomic, assign) CGFloat top;         ///< frame.origin.y
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign, readonly) CGFloat right; // 最大X
@property (nonatomic, assign, readonly) CGFloat bottom; // 最大Y
@property (nonatomic, assign) CGPoint origin;

//@property (nonatomic, strong, readonly) CAGradientLayer *gradientLayer;

/**
 创建label

 @param font 字体大小
 @param color 字体颜色
 @param textAlignment 对齐方式
 @return label
 */
+ (UILabel *)creatLabelWithFont:(CGFloat)font color:(UIColor *)color textAliment:(NSTextAlignment)textAlignment;

/**
 创建tableview

 @param frame frame
 @param style style
 @param headRefresh 下拉操作
 @param footRefresh 上拉操作
 @param delegate UITableViewDelegate，UITableViewDataSource代理
 @return tableview
 */
+ (UITableView *)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style HeadRefresh:(void(^)(void))headRefresh footRefresh:(void(^)(void))footRefresh delegate:(id<UITableViewDelegate,UITableViewDataSource>)delegate;


/**
 添加子视图数组

 @param views 子视图数组
 */
- (void)addSubviews:(NSArray *)views;

/**
 给定width 计算height

 @param value string
 @param font 字体大小
 @param width 给定的width
 @return rect
 */
+ (CGRect)rectForString:(NSString *)value font:(UIFont*)font andWidth:(float)width;

/**
 在底部添加一个横线

 @param color 横线颜色
 */
- (void)addBottomLineWithColor:(UIColor *)color;

/**
 移除子视图
 */
- (void)removeAllSubviews;

/**
 *  给view边框 画虚线
 *
 *  @param size      虚线单位size
 *  @param spacing   间隔
 *  @param color    虚线颜色
 *  @param radius    边框虚线的圆角
 */
- (void)drawRectDotterLineWithSize:(CGSize)size andSpacing:(CGFloat)spacing andColor:(UIColor *)color andcCornerRadius:(CGFloat)radius;

/**
 画虚线
 
 @param lineLength 单个虚线的width
 @param lineSpacing 虚线之间的space
 @param lineColor 虚线的颜色
 */
- (void)drawTransverseDotterLineWithLength:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor;

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 */
- (void)drawLineOfDashByCAShapeLayerlineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;

/// 查找子视图且不会保存
///
/// @param view      要查找的视图
/// @param clazzName 子控件类名
///
/// @return 找到的第一个子视图
+ (UIView *)ff_foundViewInView:(UIView *)view clazzName:(NSString *)clazzName;

/**
 layer的缩放动画

 @param layer layer
 @param type 动画方式
 */
+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(TZOscillatoryAnimationType)type;

/**
 *  自定义边框
 *
 *  @param cornerRadius 角落半径
 *  @param borderWidth  边框宽度
 *  @param color        边框颜色
 */
- (void)setBorderCornerRadius:(CGFloat)cornerRadius andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)color;

/**
 *  设置阴影
 */
- (void)setShadow:(UIColor *)color;

@end
