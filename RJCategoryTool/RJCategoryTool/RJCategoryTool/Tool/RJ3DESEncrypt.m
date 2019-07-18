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
//http://tool.chacuo.net/crypt3des
@implementation RJ3DESEncrypt


/**
 加密

 @param string 要加密的字符串
 @param key key值
 @param iv 偏移量
 @return 加密后的结果
 */
+ (NSString*)rj_encryptWithString:(NSString*)string key:(NSString *)key iv:(NSString *)iv{
    return [RJ3DESEncrypt encryptWithText:string op:kCCEncrypt key:key iv:iv];
}
/**
 解密
 
 @param string 要解密的字符串
 @param key key值
 @param iv 偏移量
 @return 解密后的结果
 */
+ (NSString*)rj_decryptWithString:(NSString*)string key:(NSString *)key iv:(NSString *)iv{
    return [RJ3DESEncrypt encryptWithText:string op:kCCDecrypt  key:key iv:iv];
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

@end
