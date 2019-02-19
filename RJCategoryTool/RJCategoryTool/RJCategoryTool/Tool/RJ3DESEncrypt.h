//
//  RJ3DESEncrypt.h
//  RJCategoryTool
//
//  Created by apple on 2019/2/19.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJ3DESEncrypt : NSObject

/**
 * 加密 : 示例 : 通用的 hb_lkey 邀请函的 hb_phoneKey 手机号码 验证码 hb_identifyingKey
 */
+ (NSString*)rj_3des_encrypt:(NSString*)plainText key:(NSString *)key;
/**
 * 解密 : 示例 : 通用的 hb_lkey 邀请函的 hb_phoneKey 手机号码 验证码 hb_identifyingKey
 */
+ (NSString*)rj_3des_decrypt:(NSString*)encryptText key:(NSString *)key ;


/// 设置登录用户的userSecretKey
+ (void)setUserSecretKey:(NSString *)userSecretKey;

/// 获取登录用户的userSecretKey
+ (NSString *)userSecretKey;

/**
 * 二维码加密方法 (生产二维码)
 */
+ (NSString*)encrypt:(NSString*)plainText;

/**
 * 二维码转账解密方法
 */
+ (NSString*)decrypt:(NSString*)encryptText;

@end

NS_ASSUME_NONNULL_END
