//
//  UIImage+Image.h
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
// instancetype默认会识别当前是哪个类或者对象调用，就会转换成对应的类的对象


+ (instancetype)ff_imagePathWithName:(NSString *)imageName bundle:(NSString *)bundle targetClass:(Class)targetClass;

// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

/**
 创建一个拉伸点在中间的图片

 @param imageName 图片名称
 @return 图片对象
 */
+ (instancetype)imageWithStretchableName:(NSString *)imageName;

/**画虚线**/
+ (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView color:(UIColor *)color;

///绘图
+ (UIImage *)createImageWithColor:(UIColor *)color;

///绘图
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  遮罩层, RGBA=(0, 0, 0, 0.6)
 *
 *  @param maskRect  遮罩层的Rect
 *  @param clearRect 镂空的Rect
 *
 *  @return 遮罩层图片
 */
+ (UIImage *)maskImageWithMaskRect:(CGRect)maskRect clearRect:(CGRect)clearRect;

/**
 根据图片流获取图片
 
 @param imageBuffer 图片流
 @return 图片对象
 */
+ (UIImage *)getImageStream:(CVImageBufferRef)imageBuffer;

/**
 截取图片的指定区域
 
 @param rect 指定区域
 @param image 原图片
 @return 裁剪后的图片
 */
+ (UIImage *)getSubImage:(CGRect)rect inImage:(UIImage*)image;

#pragma mark -

/**
 image 重新绘制 非等比绘制
 
 @param newSize 绘制的size
 @return 绘制后的image
 */
-(UIImage*)imageScaledToSize:(CGSize)newSize;

/**
 image重新绘制 （等比绘制比例为 max(newsize.width/image.size.width,newsize.height/image.size.height)） 然后截取图片中间的newsize部分
 
 @param newSize 新的size
 @return 绘制后的image
 */
-(UIImage*)imageScaledToSize2:(CGSize)newSize;

/**
 image重新绘制 （width为屏幕宽  高度为 screenW/newSize.width * newSize.height   非等比绘制）  然后截取上下居中，偏左部分的newsize大小的图片
 
 @param newSize newSize 新的size
 @return 绘制后的image
 */
-(UIImage*)imageScaledToSize3:(CGSize)newSize;

/**
 图片等比例缩放，以dstsize width为准 然后 截取 dstsize尺寸的图片（高度上做截取）
 
 @param dstSize 目标磁村
 @return 裁剪后的图片
 */
-(UIImage*)resizedImageToSize:(CGSize)dstSize;

/**
 scale为NO 且boundingSize.width和height > image.width 和 height 绘制原图
 scale为YES  或者 boundingSize.width和sheight不同时大于 imagede width 和 height 那么 会得到一个新的区域boundsize  等比改造一下 已宽高比中小的为基准，然后图偏等比缩放，已新区域的width为基准等比缩放图片（高度上做截取）
 
 @param boundingSize 传入区域
 @param scale 图片是否可以放大
 @return 裁剪后的图片
 */
-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

/** 纠正图片的方向 */
- (UIImage *)fixOrientation;

/** 按给定的方向旋转图片 */
- (UIImage*)rotate:(UIImageOrientation)orient;

/** 垂直翻转 */
- (UIImage *)flipVertical;

/** 水平翻转 */
- (UIImage *)flipHorizontal;

/** 将图片旋转degrees角度 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/** 将图片旋转radians弧度 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

- (UIImage *)imageMiddleByWidthScale:(CGFloat)widthScale andHeightScale:(CGFloat)heightScale;

@end
