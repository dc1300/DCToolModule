//
//  UIView+view.m
//  BrightSunnySky
//
//  Created by zhoujunchun on 2018/6/27.
//  Copyright © 2018年 PURANG. All rights reserved.
//

#import "UIView+view.h"
#import "MJRefresh.h"

@implementation UIView (view)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}
//- (void)setGradientLayer:(CAGradientLayer *)gradientLayer{
//    [self.layer addSublayer:gradientLayer];
//}

+ (UILabel *)creatLabelWithFont:(CGFloat)font color:(UIColor *)color textAliment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    label.textAlignment = textAlignment;
    return label;
}

+ (UITableView *)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style HeadRefresh:(void(^)(void))headRefresh footRefresh:(void(^)(void))footRefresh delegate:(id<UITableViewDelegate,UITableViewDataSource>)delegate{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    if (delegate) {
        tableView.dataSource = delegate;
        tableView.delegate = delegate;
    }
    if (headRefresh) {
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:headRefresh];
    }
    if (footRefresh) {
        MJRefreshAutoStateFooter *foot = [MJRefreshAutoStateFooter footerWithRefreshingBlock:footRefresh];
        tableView.mj_footer = foot;
    }
    
    return tableView;
}

+ (CGRect)rectForString:(NSString *)value font:(UIFont*)font andWidth:(float)width {
    CGRect rect = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return CGRectMake(rect.origin.x, rect.origin.y, ceil(rect.size.width), ceil(rect.size.height));
}

- (void)addBottomLineWithColor:(UIColor *)color {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    [self addSubview:line];
    line.frame = CGRectMake(0, 0.8, self.frame.size.width, 0.8);
}

- (void)addSubviews:(NSArray *)views{
    for (UIView *v in views) {
        [self addSubview:v];
    }
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView *childV = self.subviews.lastObject;
        [childV removeFromSuperview];
    }
}

- (void)drawRectDotterLineWithSize:(CGSize)size andSpacing:(CGFloat)
spacing andColor:(UIColor *)color andcCornerRadius:(CGFloat)radius{
    CAShapeLayer *layer = [CAShapeLayer layer];
    [layer setFrame:self.bounds];
    [layer setStrokeColor:color.CGColor];
    [layer setFillColor:[UIColor clearColor].CGColor];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    layer.path = path.CGPath;
    if (size.width > self.width || size.height > self.height) {
        NSAssert(NO, @"虚线size值不可以超过矩形size");
    }
    layer.lineWidth = size.height;
    layer.lineDashPattern =  @[[NSNumber numberWithFloat:size.width], [NSNumber numberWithFloat:spacing]];
    [self.layer addSublayer:layer];
    if (radius >= 0) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;
    }else{
        NSAssert(NO, @"radius值不能小于零");
    }
}

- (void)drawTransverseDotterLineWithLength:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:self.bounds];
    
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

- (void)drawLineOfDashByCAShapeLayerlineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    
    if (isHorizonal) {
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    } else {
        [shapeLayer setLineWidth:CGRectGetWidth(self.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(self.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

+ (UIView *)ff_foundViewInView:(UIView *)view clazzName:(NSString *)clazzName {
    // 递归出口
    if ([view isKindOfClass:NSClassFromString(clazzName)]) {
        return view;
    }
    // 遍历所有子视图
    for (UIView *subView in view.subviews) {
        UIView *foundView = [self ff_foundViewInView:subView clazzName:clazzName];
        if (foundView) {
            return foundView;
        }
    }
    return nil;
}

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(TZOscillatoryAnimationType)type{
    NSNumber *animationScale1 = type == TZOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == TZOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

/**
 *  自定义边框
 *
 *  @param cornerRadius 角落半径
 *  @param borderWidth  边框宽度
 *  @param color        边框颜色
 */
-(void)setBorderCornerRadius:(CGFloat)cornerRadius andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)color{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = color.CGColor;
}

/**
 *  设置阴影
 */
- (void)setShadow:(UIColor *)color{
    self.layer.shadowPath =[UIBezierPath bezierPathWithRect:self.layer.bounds].CGPath;
    self.layer.shadowColor = color.CGColor;//阴影的颜色
    self.layer.shadowOpacity = 0.5f;   // 阴影透明度
    self.layer.shadowOffset = CGSizeMake(2,2); // 阴影的范围
    self.layer.shadowRadius = 2;  // 阴影扩散的范围控制
}

@end
