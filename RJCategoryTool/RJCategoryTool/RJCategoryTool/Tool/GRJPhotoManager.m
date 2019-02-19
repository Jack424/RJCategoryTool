//
//  GRJPhotoManager.m
//  HobayCn
//
//  Created by 易上云 on 2017/5/5.
//  Copyright © 2017年 Yi Cloud. All rights reserved.
//

#import "GRJPhotoManager.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import "UIAlertController+GRJAlert.h"
#import "RJInitViewTool.h"
#import <CoreServices/CoreServices.h>
@implementation GRJPhotoManager

// 获取已有相册
+ (PHAssetCollection *)getAssetCollection:(NSString *)title
{
    // 获取到相册结构集
    PHFetchResult *results = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in results) {
        
        if ([assetCollection.localizedTitle isEqualToString:title]) {
            return assetCollection;
        }
    }
    
    return nil;
}

+ (void)addImage:(UIImage *)image toAlbum:(NSString *)title completionHandler:(void(^)(BOOL success, NSError *error))completionHandler
{
    if (!image || (title.length < 1)) {
        return;
    }
    // 获取相簿
    PHPhotoLibrary *lib = [PHPhotoLibrary sharedPhotoLibrary];
    
    [lib performChanges:^{
        // 只有在这个Block中才能对相册进行操作
        // 先判断是否已有自定义相册，如果有自定义相册，直接把图片添加到已有相册
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest;
        
        // 获取相册
        PHAssetCollection *assetCollection = [self getAssetCollection:title];
        
        if (assetCollection) {
            // 有自定义相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else {
            // 创建自定义相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
        }
        
        // 2.创建图片请求对象
        PHAssetChangeRequest *assetRequset = [PHAssetCreationRequest creationRequestForAssetFromImage:image];
        
        // 3.把图片放在自定义相册 PHAsset:照片
        [assetCollectionChangeRequest addAssets:@[assetRequset.placeholderForCreatedAsset]];
        
    } completionHandler:completionHandler];
    
}


/**
 判断是否获取了相机的权限
 
 @param success 成功的回调
 */
+(void)isGetSystemCameraAuthorization:(void(^)(void))success{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        //无权限
        [[self class] alertTips];
    }else{
        if (success) {
            success();
        }
    }
}

/**
 判断是否获取了相册的权限
 
 @param success 成功的回调
 */
+(void)isGetSystemAssetsAuthorization:(void(^)(void))success{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
        //无权限
        [[self class] alertTips];
    }
    else if (author == kCLAuthorizationStatusNotDetermined){
        PHPhotoLibrary *lib = [PHPhotoLibrary sharedPhotoLibrary];
        [lib performChanges:^{

        } completionHandler:^(BOOL success, NSError * _Nullable error) {

        }];
    }
    else{
        if (success) {
            success();
        }
    }
 
}

+(void)alertTips{
    // 方式一 弹窗
    [UIAlertController ShowAlertOneWithViewController:[UIApplication sharedApplication].keyWindow.rootViewController Title:@"提示" message:@"请在设备的\"设置-隐私-相机/相册\"中允许访问相机/相册。" actionSureTitle:@"确定" sure:^{
        
    }];
    
    // 方式一 弹窗 进入到设置界面
//    [UIAlertController ShowAlertWithViewController:[UIApplication sharedApplication].keyWindow.rootViewController Title:@"" message:@"应用未获得您的访问权限,要设置吗?" actionTitle:@"确定" sure:^{
//        NSString * urlString = @"App-Prefs:root=Privacy";
//        
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
//            
//            if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
//            } else {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//            }
//        }
//    }];
}
+(void)rj_selectedImageShowWithViewOrController:(id)viewOrController{//[GRJGetVCFromV viewControllerFromView:self]
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //[viewOrController isKindOfClass:[UIView class]]?[GRJGetVCFromV viewControllerFromView:viewOrController]:viewOrController
        [GRJPhotoManager cameraWithViewOrController:viewOrController Tag:1];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [GRJPhotoManager cameraWithViewOrController:viewOrController Tag:2];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    [[viewOrController isKindOfClass:[UIView class]]?[RJInitViewTool rj_getViewControllerFromView:viewOrController]:viewOrController presentViewController:alertController animated:YES completion:nil];
}


+(void)cameraWithViewOrController:(id)viewOrController Tag:(NSInteger)tag{
    
    UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.delegate = viewOrController;
    //imagePickerVC.allowsEditing = YES;
    if (tag == 1) {//拍照
        [GRJPhotoManager isGetSystemCameraAuthorization:^{
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [[viewOrController isKindOfClass:[UIView class]]?[RJInitViewTool rj_getViewControllerFromView:viewOrController]:viewOrController presentViewController:imagePickerVC animated:YES completion:nil];
        }];
        
    } else {//相册
        
        [GRJPhotoManager isGetSystemAssetsAuthorization:^{
            imagePickerVC.modalPresentationStyle= UIModalPresentationOverFullScreen;
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerVC.mediaTypes = @[(NSString *)kUTTypeImage];
            [[viewOrController isKindOfClass:[UIView class]]?[RJInitViewTool rj_getViewControllerFromView:viewOrController]:viewOrController presentViewController:imagePickerVC animated:YES completion:nil];
            
        }];
    }
    
}
@end
