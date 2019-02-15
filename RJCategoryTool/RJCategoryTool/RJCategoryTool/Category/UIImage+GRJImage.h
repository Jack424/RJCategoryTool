//
//  UIImage+GRJImage.h
//  GRJTolCayFrwk
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GRJImage)

//生成一张圆形的图片
+ (instancetype)grj_circleImageWithName:(NSData *)name image:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;





/** 返回一张没有经过渲染的图片 */
+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName;


// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)miniImageWithColor:(UIColor *)color;

// 返回一张可以拉伸的图片
+ (instancetype)resizableImage:(NSString *)name;

/** 返回圆形图片 */
+(instancetype)circleImageWithName:(NSString *)imageName;
-(instancetype)circleImage;


/**
 *  根据图片名自动加载适配iOS6\7的图片
 */
+ (UIImage *)imageWithName:(NSString *)name;


+(UIImage *)randomImage;

+(NSString *)randomImageURL;

+(NSString *)randomName;

/** 返回一张不超过屏幕尺寸的 image */
+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image;




/************************         谷瑞杰         *****************************/

/** 
 把原图片生成指定的尺寸  (2017-06-06)
 */
+ (UIImage *)image:(UIImage *)image byScalingToSize:(CGSize)targetSize;

/************************         谷瑞杰         *****************************/

/**
 根据颜色和大小生成图片
 
 @param color 颜色
 @param size 大小
 @return 生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;


@end
