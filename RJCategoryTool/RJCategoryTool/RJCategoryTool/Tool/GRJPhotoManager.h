//
//  GRJPhotoManager.h
//  HobayCn
//
//  Created by 易上云 on 2017/5/5.
//  Copyright © 2017年 Yi Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class PHAssetCollection;
@interface GRJPhotoManager : NSObject

/**
 *  添加图片到自定义相册
 *
 *  @param image 图片
 *  @param title 相册名字
 */
+ (void)addImage:(UIImage *)image toAlbum:(NSString *)title completionHandler:(void(^)(BOOL success, NSError *error))completionHandler;

/**
 *  指定相册名字获取已有相册
 *
 *  @param title 相册名字
 *
 *  @return 相册对象
 */
+ (PHAssetCollection *)getAssetCollection:(NSString *)title;


/**
 判断是否获取了相机的权限
 
 @param success 成功的回调
 */
+(void)isGetSystemCameraAuthorization:(void(^)(void))success;


/**
 判断是否获取了相册的权限
 
 @param success 成功的回调
 */
+(void)isGetSystemAssetsAuthorization:(void(^)(void))success;


+(void)rj_selectedImageShowWithViewOrController:(id)viewOrController;
@end
