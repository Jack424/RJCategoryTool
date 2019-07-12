//
//  HttpRequest.h
//  BMTransCity
//
//  Created by apple on 2019/5/20.
//  Copyright © 2019 JinTian. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^httpSuccessBlock)(id _Nonnull responseObject) ;
typedef void (^httpExceptionBlock)(id _Nullable exception) ;
typedef void (^httpFailureBlock)(NSError * _Nonnull error);

typedef void (^httpProgressBlock)(id _Nonnull progress);//EXCEPTION
NS_ASSUME_NONNULL_BEGIN

@interface HttpRequest : NSObject
/**
 GET
 */
+ (void)getHTTPWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success failure:(httpFailureBlock)failure;
+(void)getJSONWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success failure:(httpFailureBlock)failure;
/**
 POST
 */
+ (void)postHTTPWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success failure:(httpFailureBlock)failure;
+(void)postJSONWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success failure:(httpFailureBlock)failure;
/**
 PUT
 */
+ (void)putHTTPWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success failure:(httpFailureBlock)failure;
+(void)putJSONWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success failure:(httpFailureBlock)failure;
/**
 DELETE
 */
+ (void)deleteHTTPWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success failure:(httpFailureBlock)failure;
+(void)deleteJSONWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success failure:(httpFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
