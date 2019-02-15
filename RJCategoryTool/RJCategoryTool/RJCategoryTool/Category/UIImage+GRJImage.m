//
//  UIImage+GRJImage.m
//  GRJTolCayFrwk
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 Global Barter. All rights reserved.
//

#import "UIImage+GRJImage.h"
#import "RJMainMacros.h"
@implementation UIImage (GRJImage)



//一 生成一张圆形的图片
+ (instancetype)grj_circleImageWithName:(NSData *)name image:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = image;
    if (oldImage == nil) {
        oldImage = [UIImage imageWithData:name];
        if (oldImage == nil) {
            oldImage = [UIImage imageNamed:@"person_icon"];
        }
    }
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}



//二 把原图片生成指定的尺寸
+ (UIImage *)image:(UIImage *)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}





//三 返回一张没有被渲染的图片
+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    // 返回一张原始图片给你
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



//四 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)miniImageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.5f, 1.0f, 0.5f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

//五 返回一张可以拉伸的图片
+(instancetype)resizableImage:(NSString *)name{
    UIImage *bg = [self imageNamed:name];
    return [bg stretchableImageWithLeftCapWidth:bg.size.width * 0.5 topCapHeight:bg.size.height * 0.5];
}

//六 返回圆形图片
-(instancetype)circleImage{
    // 只要想生成新的图片 => 图形上下文
    //开启图文上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    //描述裁剪区域
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    //提交裁剪区域
    [bezierPath addClip];
    
    //画图片
    [self drawAtPoint:CGPointZero];
    
    //取出图片
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return circleImage;
}

+(instancetype)circleImageWithName:(NSString *)imageName{
    return [[UIImage imageNamed:imageName] circleImage];
}


+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) { // 处理iOS7的情况
        NSString *newName = [name stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:newName];
    }
    
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    return image;
}



+(UIImage *)randomImage{
    
    NSMutableArray *imgNameArr = [NSMutableArray array];
    for (int i = 1; i < 5; i++) {
        NSString *imgStr = [NSString stringWithFormat:@"home_image_%d",i];
        [imgNameArr addObject:imgStr];
    }
    int x = arc4random() % 4;
    UIImage *img = [UIImage imageNamed:imgNameArr[x]];
    
    return img;
}
+(NSString *)randomName{
    NSArray *nameArr = @[@"幼稚园新童鞋",@"少女的英雄梦",@"章鱼小肉丸",@"天赐淡雅香",@"笑弄清风"];
    return nameArr[arc4random()%4];
}
+(NSString *)randomImageURL{
    NSArray *imgNameArr = @[@"https://upload-images.jianshu.io/upload_images/14982866-643cb2d204a51b9a.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/601",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546078954972&di=ebaa3516a599b8b1f7998add529d59bd&imgtype=0&src=http%3A%2F%2Ftx.haiqq.com%2Fuploads%2Fallimg%2F170508%2F0203542R6-3.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546078596630&di=215c492d545a8021eee7377367424a1e&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201609%2F25%2F20160925183301_jLAUV.jpeg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546078596627&di=3d14ab5a4b46781947c9c346500dc1e1&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F72a41948065f01bd99a2153de56d4a5b516c281484dae-6ZKZnw_fw236",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546078596626&di=e1f79df8fcaf081bd691f5136385cead&imgtype=0&src=http%3A%2F%2Fimgtu.5011.net%2Fuploads%2Fcontent%2F20170602%2F6833191496392236.jpg",
                            ];
    return imgNameArr[arc4random()%4];
}


/// 返回一张不超过屏幕尺寸的 image
+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image {
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat screenWidth = rj_kScreenWidth;
    CGFloat screenHeight = rj_kScreenHeight;
    
    // 如果读取的二维码照片宽和高小于屏幕尺寸，直接返回原图片
    if (imageWidth <= screenWidth && imageHeight <= screenHeight) {
        return image;
    }
    
    //SGQRCodeLog(@"压缩前图片尺寸 － width：%.2f, height: %.2f", imageWidth, imageHeight);
    CGFloat max = MAX(imageWidth, imageHeight);
    // 如果是6plus等设备，比例应该是 3.0
    CGFloat scale = max / (screenHeight * 2.0f);
    //SGQRCodeLog(@"压缩后图片尺寸 － width：%.2f, height: %.2f", imageWidth / scale, imageHeight / scale);
    
    return [UIImage imageWithImage:image scaledToSize:CGSizeMake(imageWidth / scale, imageHeight / scale)];
}
/// 返回一张处理后的图片
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (color == nil) {
        return nil;
    }
    
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
