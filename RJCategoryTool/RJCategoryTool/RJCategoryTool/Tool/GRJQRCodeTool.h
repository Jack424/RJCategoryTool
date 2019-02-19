//
//  GRJQRCodeTool.h
//  HobayCn
//
//  Created by 易上云 on 2017/4/24.
//  Copyright © 2017年 Yi Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, GRJQRCodeSaveImageType) {
    GRJQRCodeSaveImageTypeRecommend, //我推荐的
    GRJQRCodeSaveImageTypePay //扫一扫付款
};

@interface GRJQRCodeTool : NSObject
/** 生成一张普通的二维码 */
+(UIImage *)qRCodeCreatQRCodeWithString:(NSString *)codeString;
/** 生成一张清晰的二维码 */
+(UIImage *)qRCodeCreatClearQRCodeWithString:(NSString *)codeString withImageSize:(CGFloat)size;
/** 生成一张彩色的二维码 */
+(UIImage *)qRCodeCreatClearQRCodeWithString:(NSString *)codeString lineColor:(CIColor *)lineColor backgroundColor:(CIColor *)backgroundColor;
/** 生成一张带有logo的二维码（logoScaleToSuperView：相对于父视图的缩放比取值范围0-1；0，不显示，1，代表与父视图大小相同） */
+(UIImage *)qRCodeCreatClearQRCodeWithString:(NSString *)codeString logoImage:(UIImage *)logoImage logoScaleToSuperView:(CGFloat)logoScaleToSuperView;

/** 保存图片 */

/**
 保存图片

 @param backImage 背景图
 @param QRCodeImage 二维码图片
 @return 返回保存图片
 */
//+ (UIImage *)saveImageWithBackImage:(UIImage *)backImage QRCodeImage:(UIImage *)QRCodeImage GRJQRCodeSaveImageType:(GRJQRCodeSaveImageType)GRJQRCodeSaveImageType;
//收款二维码保存图片
+ (UIImage *)saveShouKuanImageWithBackImage:(UIImage *)backImage QRCodeImage:(UIImage *)QRCodeImage Name:(NSString *)name;
/**
 保存图片
 
 @param backImage 背景图
 @param QRCodeImage 二维码图片
 @param name 名称
 @return 返回保存图片
 */

+ (UIImage *)saveImageWithBackImage:(UIImage *)backImage QRCodeImage:(UIImage *)QRCodeImage Name:(NSString *)name;
@end
