//
//  GRJQRCodeTool.m
//  HobayCn
//
//  Created by 易上云 on 2017/4/24.
//  Copyright © 2017年 Yi Cloud. All rights reserved.
//

#import "GRJQRCodeTool.h"
#import "NSString+RJString.h"
#import "NSObject+RJCheck.h"

@implementation GRJQRCodeTool


/**
 字符串生成一张不作处理的二维码

 @param codeString 传入你要生成二维码的数据
 @return 原生二维码图片
 */
+(UIImage *)qRCodeCreatQRCodeWithString:(NSString *)codeString{
    
    CIImage *outputImage = [GRJQRCodeTool ciimageWithString:codeString];
    
    //return  [UIImage imageWithCIImage:outputImage scale:5 orientation:UIImageOrientationUp];
    return [UIImage imageWithCIImage:outputImage];
}
/**
 字符串生成一张清晰的二维码
 
 @param codeString 传入你要生成二维码的数据
 @param size 图片大小
 @return 原生二维码图片
 */
+(UIImage *)qRCodeCreatClearQRCodeWithString:(NSString *)codeString withImageSize:(CGFloat)size{
    
    CIImage *outputImage = [GRJQRCodeTool ciimageWithString:codeString];
    
    return [GRJQRCodeTool createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
}


/**
 生成附带插图的二维码图片

 @param codeString 传入你要生成二维码的数据
 @param logoImage 插入的图片
 @param logoScaleToSuperView sac
 @return 带插图的二维码图片
 */
+ (UIImage *)qRCodeCreatClearQRCodeWithString:(NSString *)codeString
                                   logoImage:(UIImage *)logoImage
                        logoScaleToSuperView:(CGFloat)logoScaleToSuperView{
    if ([NSString rj_stringIsEmpty:codeString]) {
        return nil;
    }
    CIImage *outputImage = [GRJQRCodeTool ciimageWithString:codeString];
    if ([NSObject rj_objIsEmpty:outputImage]) {
        return nil;
    }
    UIImage *start_image = [UIImage imageWithCIImage:outputImage];
    if ([NSObject rj_objIsEmpty:start_image]) {
        return nil;
    }
    // - - - - - - - - - - - - - - - - 添加中间小图标 - - - - - - - - - - - - - - - -
    // 5、开启绘图, 获取图形上下文 (上下文的大小, 就是二维码的大小)
    UIGraphicsBeginImageContext(start_image.size);
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [start_image drawInRect:CGRectMake(0, 0, start_image.size.width, start_image.size.height)];
    // 再把小图片画上去
    if (![NSObject rj_objIsEmpty:logoImage]) {
        UIImage *icon_image = logoImage;
        CGFloat icon_imageW = start_image.size.width * logoScaleToSuperView;
        CGFloat icon_imageH = start_image.size.height * logoScaleToSuperView;
        
        CGFloat icon_imageX = (start_image.size.width - icon_imageW) * 0.5;
        CGFloat icon_imageY = (start_image.size.height - icon_imageH) * 0.5;
        
        [icon_image drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
    }
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    
    return final_image;
}


/**
 *  生成一张彩色的二维码
 *
 *  @param codeString    传入你要生成二维码的数据
 *  @param backgroundColor    背景色
 *  @param lineColor   线条颜色
 */
+(UIImage *)qRCodeCreatClearQRCodeWithString:(NSString *)codeString lineColor:(CIColor *)lineColor backgroundColor:(CIColor *)backgroundColor {
    
    CIImage *outputImage = [GRJQRCodeTool ciimageWithString:codeString];
    
    // 图片小于(27,27),我们需要放大
    //outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(9, 9)];
    // 4、创建彩色过滤器(彩色的用的不多)
    CIFilter * color_filter = [CIFilter filterWithName:@"CIFalseColor"];
    // 设置默认值
    [color_filter setDefaults];
    // 5、KVC 给私有属性赋值
    [color_filter setValue:outputImage forKey:@"inputImage"];
    // 6、需要使用 CIColor
    [color_filter setValue:lineColor forKey:@"inputColor0"];
    [color_filter setValue:backgroundColor forKey:@"inputColor1"];
    // 7、设置输出
    CIImage *colorImage = [color_filter outputImage];
    
    return [UIImage imageWithCIImage:colorImage];
    
}


/**
 字符串生成CIImage

 @param codeString 要转换的字符串
 @return CIImage
 */
+(CIImage *)ciimageWithString:(NSString *)codeString{
    if ([NSString rj_stringIsEmpty:codeString]) {
        return nil;
    }
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

    // 恢复滤镜的默认属性
    [filter setDefaults];
    // 3.给过滤器添加数据
    NSData *data = [codeString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    // 图片小于(27,27),我们需要放大
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(10, 10)];
    return outputImage;
}

/**
 图片清晰处理

 @param image CIImage
 @param size 图片大小
 @return 处理好的图片
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
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


//+ (UIImage *)saveImageWithBackImage:(UIImage *)backImage QRCodeImage:(UIImage *)QRCodeImage GRJQRCodeSaveImageType:(GRJQRCodeSaveImageType)GRJQRCodeSaveImageType{
//    //加载要添加水印的图片
//    //生成图片(要开启一个位图上下文)
//    UIGraphicsBeginImageContext(backImage.size);
//    //NSLog(@"%@",NSStringFromCGSize(image.size));
//    //把图片绘制到上下文当中
//    [backImage drawAtPoint:CGPointZero];
//    UIFont *font = [UIFont systemFontOfSize:50.0f];
//    NSString *text;
//    [QRCodeImage drawInRect:CGRectMake(285, 260, 510, 510)];
//
//    switch (GRJQRCodeSaveImageType) {
//        case GRJQRCodeSaveImageTypeRecommend:
//            font = [UIFont systemFontOfSize:45*kMainScreenWidth/375];
//            text = @"";
//            if (![NSString isEmpty:[kHBUserData userData].name]) {
//                text = [NSString stringWithFormat:@"%@\n", [kHBUserData userData].name];
//            }
//
//            text = [NSString stringWithFormat:@"%@邀请您加入焕呗，10万+商企老板在换货，就差你了！",text];
//
//            break;
//        case GRJQRCodeSaveImageTypePay:
//
//            text = [NSString stringWithFormat:@"使用焕呗APP扫二维码向%@(%@)付款",[kHBUserData userData].DisplayName.length>0?[kHBUserData userData].DisplayName:@"",[kHBUserData userData].name];
//            break;
//        default:
//            break;
//    }
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//    NSInteger textW = [text sizeWithFont:font forWidth:1000 lineBreakMode:NSLineBreakByWordWrapping].width;
//#pragma clang diagnostic pop
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    // 行间距
//    paragraphStyle.lineSpacing = 10.f;
//    // 对齐方式
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//
//    [text drawInRect:CGRectMake(540-textW/2, 855, 1000, 220) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor], NSParagraphStyleAttributeName:paragraphStyle}];
//    //从上下文当中生成一张图片
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    //手动开启的上下文必须得要手动去关闭才行.
//    UIGraphicsEndImageContext();
//
//    return newImage;
//}
+ (UIImage *)drawCornerWithImage:(UIImage *)image{
    UIImage *modifiedImage;
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
    
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0] addClip];
    [image drawInRect:rect];
    modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return modifiedImage;
}
+ (UIImage *)saveShouKuanImageWithBackImage:(UIImage *)backImage QRCodeImage:(UIImage *)QRCodeImage Name:(NSString *)name{
    //加载要添加水印的图片
    //生成图片(要开启一个位图上下文)
    UIGraphicsBeginImageContext(backImage.size);//414 562
    //NSLog(@"%@",NSStringFromCGSize(image.size));
    //把图片绘制到上下文当中
    [backImage drawAtPoint:CGPointZero];
    [[GRJQRCodeTool drawCornerWithImage:QRCodeImage] drawInRect:CGRectMake(95+3, 125+1, 220-3, 220-3)];
    
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
+ (UIImage *)saveImageWithBackImage:(UIImage *)backImage QRCodeImage:(UIImage *)QRCodeImage Name:(NSString *)name{
    //加载要添加水印的图片
    //生成图片(要开启一个位图上下文)
    UIGraphicsBeginImageContext(backImage.size);
    //NSLog(@"%@",NSStringFromCGSize(image.size));
    //把图片绘制到上下文当中
    [backImage drawAtPoint:CGPointZero];
    [QRCodeImage drawInRect:CGRectMake(285, 260, 510, 510)];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSInteger textW = [name sizeWithFont:[UIFont systemFontOfSize:50.0f] forWidth:1000 lineBreakMode:NSLineBreakByWordWrapping].width;
#pragma clang diagnostic pop    
    [name drawInRect:CGRectMake(540-textW/2, 855, 1000, 70) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:50.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //手动开启的上下文必须得要手动去关闭才行.
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
