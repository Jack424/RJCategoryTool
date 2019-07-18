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
 加密
 
 @param string 要加密的字符串
 @param key key值
 @param iv 偏移量
 @return 加密后的结果
 */
+ (NSString*)rj_encryptWithString:(NSString*)string key:(NSString *)key iv:(NSString *)iv;
/**
 解密
 
 @param string 要解密的字符串
 @param key key值
 @param iv 偏移量
 @return 解密后的结果
 */
+ (NSString*)rj_decryptWithString:(NSString*)string key:(NSString *)key iv:(NSString *)iv;
@end

NS_ASSUME_NONNULL_END
