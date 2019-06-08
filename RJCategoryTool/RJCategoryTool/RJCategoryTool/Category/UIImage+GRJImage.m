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
+ (UIImage *)rj_imageWithColor:(UIColor *)color
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





+ (UIImage *)saveShouKuanImageWithBackImage:(UIImage *)backImage
                                QRCodeImage:(UIImage *)QRCodeImage
                                       Name:(NSString *)name {
    //加载要添加水印的图片
    //生成图片(要开启一个位图上下文)
    UIGraphicsBeginImageContext(backImage.size);//414 562
    //NSLog(@"%@",NSStringFromCGSize(image.size));
    //把图片绘制到上下文当中
    [backImage drawAtPoint:CGPointZero];
    [[QRCodeImage drawCornerWithCornerRadius:5.0] drawInRect:CGRectMake(95+3, 125+1, 220-3, 220-3)];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSInteger textW = [name sizeWithFont:[UIFont systemFontOfSize:22.0f] forWidth:414 lineBreakMode:NSLineBreakByWordWrapping].width;
#pragma clang diagnostic pop
    [name drawInRect:CGRectMake(207-textW/2, 360, 414, 70) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //手动开启的上下文必须得要手动去关闭才行.
    UIGraphicsEndImageContext();
    
    return newImage;
}
/**
 *  生成一张普通的二维码
 *
 *  @param data    传入你要生成二维码的数据
 *  @param imageViewWidth    图片的宽度
 */
+ (UIImage *)generateWithDefaultQRCodeData:(NSString *)data imageViewWidth:(CGFloat)imageViewWidth {
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 2、设置数据
    NSString *info = data;
    // 将字符串转换成
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    
    // 通过KVC设置滤镜inputMessage数据
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:imageViewWidth];
}

/** 根据CIImage生成指定大小的UIImage */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}



- (UIImage *)resize:(CGSize)size {
    UIImage *newimage = nil;
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0,
                                0,
                                size.width,
                                size.height)];
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0,
                             0.0,
                             1.0,
                             1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSData *)compressWithMaxLength:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) {
        return data;
    }
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    if (data.length < maxLength) {
        return data;
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}

- (UIImage *)drawCornerWithCornerRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0,
                             0,
                             self.size.width,
                             self.size.height);
    UIGraphicsBeginImageContextWithOptions(self.size,
                                           false,
                                           [[UIScreen mainScreen] scale]);
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:cornerRadius] addClip];
    [self drawInRect:rect];
    UIImage *modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return modifiedImage;
}

/**
 *  生成一张带有logo的二维码
 *
 *  @param data    传入你要生成二维码的数据
 *  @param logoImage    logo的image
 *  @param logoScaleToSuperView    logo相对于父视图的缩放比（取值范围：0-1，0，代表不显示，1，代表与父视图大小相同）
 */
+ (UIImage *)generateWithLogoQRCodeData:(NSString *)data logoImage:(UIImage *)logoImage logoScaleToSuperView:(CGFloat)logoScaleToSuperView {
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 2、设置数据
    NSString *string_data = data;
    // 将字符串转换成 NSdata (虽然二维码本质上是字符串, 但是这里需要转换, 不转换就崩溃)
    NSData *qrImageData = [string_data dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置过滤器的输入值, KVC赋值
    [filter setValue:qrImageData forKey:@"inputMessage"];
    
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 图片小于(27,27),我们需要放大
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    
    // 4、将CIImage类型转成UIImage类型
    UIImage *start_image = [UIImage imageWithCIImage:outputImage];
    
    // - - - - - - - - - - - - - - - - 添加中间小图标 - - - - - - - - - - - - - - - -
    // 5、开启绘图, 获取图形上下文 (上下文的大小, 就是二维码的大小)
    UIGraphicsBeginImageContext(start_image.size);
    
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [start_image drawInRect:CGRectMake(0, 0, start_image.size.width, start_image.size.height)];
    
    // 再把小图片画上去
    CGFloat icon_imageW = start_image.size.width * logoScaleToSuperView;
    CGFloat icon_imageH = start_image.size.height * logoScaleToSuperView;
    CGFloat icon_imageX = (start_image.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY = (start_image.size.height - icon_imageH) * 0.5;
    
    [logoImage drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
    
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    
    return final_image;
}

/**
 *  生成一张彩色的二维码
 *
 *  @param data    传入你要生成二维码的数据
 *  @param backgroundColor    背景色
 *  @param mainColor    主颜色
 */
+ (UIImage *)generateWithColorQRCodeData:(NSString *)data backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor {
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 2、设置数据
    NSString *string_data = data;
    // 将字符串转换成 NSdata (虽然二维码本质上是字符串, 但是这里需要转换, 不转换就崩溃)
    NSData *qrImageData = [string_data dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置过滤器的输入值, KVC赋值
    [filter setValue:qrImageData forKey:@"inputMessage"];
    
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 图片小于(27,27),我们需要放大
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(9, 9)];
    
    // 4、创建彩色过滤器(彩色的用的不多)
    CIFilter * color_filter = [CIFilter filterWithName:@"CIFalseColor"];
    
    // 设置默认值
    [color_filter setDefaults];
    
    // 5、KVC 给私有属性赋值
    [color_filter setValue:outputImage forKey:@"inputImage"];
    
    // 6、需要使用 CIColor
    [color_filter setValue:backgroundColor forKey:@"inputColor0"];
    [color_filter setValue:mainColor forKey:@"inputColor1"];
    
    // 7、设置输出
    CIImage *colorImage = [color_filter outputImage];
    
    return [UIImage imageWithCIImage:colorImage];
}

@end
