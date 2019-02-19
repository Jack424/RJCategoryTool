//
//  RJ3DESEncrypt.m
//  RJCategoryTool
//
//  Created by apple on 2019/2/19.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import "RJ3DESEncrypt.h"
#import <CommonCrypto/CommonCryptor.h>
#import <GTMBase64/GTMBase64.h>
#import "NSString+RJString.h"

#define hb_gIv             @"01234567"
#define hb_lkey            [[RJ3DESEncrypt getNowTimeWithDay] stringByAppendingString:@"01234567891111"]
#define hb_phoneKey @"huanbei123456789huanbei0"
#define hb_identifyingKey @"huanbei123456789#$&^#$@%"
#define kHBUserSecretKey @"HBUserSecretKey"
@implementation RJ3DESEncrypt

+ (void)setUserSecretKey:(NSString *)userSecretKey {
    if ([NSString rj_stringIsEmpty:userSecretKey]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kHBUserSecretKey];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userSecretKey
                                              forKey:kHBUserSecretKey];
    /*系统会保存到该应用下的/Library/Preferences/gongcheng.plist文件中。需要注意的是如果程序意外退出，NSUserDefaultsstandardUserDefaults数据不会被系统写入到该文件，所以，要使用［[NSUserDefaultsstandardUserDefaults] synchronize］命令直接同步到文件里，来避免数据的丢失。*/
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)userSecretKey {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kHBUserSecretKey];
}

/**
 * 二维码加密方法 (生产二维码)
 */
+ (NSString *)encrypt:(NSString*)plainText {
    NSString *userSecretKey = [RJ3DESEncrypt userSecretKey];
    return [RJ3DESEncrypt rj_3des_encrypt:plainText key:userSecretKey];
}
// 二维码转账解密方法
+ (NSString *)decrypt:(NSString*)encryptText {
    NSString *userSecretKey = [RJ3DESEncrypt userSecretKey];
    return [RJ3DESEncrypt rj_3des_decrypt:encryptText key:userSecretKey];
}

/**
 * 加密 : 通用的 hb_lkey 邀请函的 hb_phoneKey 手机号码 验证码 hb_identifyingKey
 */
+ (NSString*)rj_3des_encrypt:(NSString*)plainText key:(NSString *)key{
    if ([NSString rj_stringIsEmpty:plainText]) {
        return nil;
    }
    return [RJ3DESEncrypt encryptWithText:plainText op:kCCEncrypt key:key iv:hb_gIv];
}
/**
 * 解密 : 通用的 hb_lkey 邀请函的 hb_phoneKey 手机号码 验证码 hb_identifyingKey
 */
+ (NSString*)rj_3des_decrypt:(NSString*)encryptText key:(NSString *)key {
    if ([NSString rj_stringIsEmpty:encryptText]) {
        return nil;
    }
    return [RJ3DESEncrypt encryptWithText:encryptText op:kCCDecrypt key:key iv:hb_gIv];
}
+(NSString*)encryptWithText:(NSString *)text op:(CCOperation)op key:(NSString *)key iv:(NSString *)iv{
    NSData *data;
    if (op==kCCEncrypt) {//加密
        data = [text dataUsingEncoding:NSUTF8StringEncoding];
    }else if (op==kCCDecrypt){//解密
        data = [GTMBase64 decodeData:[text dataUsingEncoding:NSUTF8StringEncoding]];
    }else{
        return nil;
    }
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [iv UTF8String];
    
    ccStatus = CCCrypt(op,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    
    if (op==kCCEncrypt) {//加密
        return [GTMBase64 stringByEncodingData:myData];
    }else if (op==kCCDecrypt){//解密
        return [[NSString alloc]initWithData:myData encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

/******************** Warning ********************/
//获取现在时间，登录专用，固定时区为上海
+ (NSString *)getNowTimeWithDay {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr = [formatter stringFromDate:date];
    return timeStr;
}
/******************** Warning ********************/
@end
