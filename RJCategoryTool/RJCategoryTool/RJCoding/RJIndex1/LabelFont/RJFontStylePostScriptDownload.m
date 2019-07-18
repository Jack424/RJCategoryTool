//
//  RJFontStylePostScriptDownload.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/18.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJFontStylePostScriptDownload.h"
#import <CoreText/CoreText.h>

@implementation RJFontStylePostScriptDownload
/* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 *//* 下载字体 */

+(void)rj_downLoadFont:(NSString *)fontName{
    if([RJFontStylePostScriptDownload rj_isFontDownloaded:fontName]){
        return;
    }
    // 用字体的 PostScript 名字创建一个 Dictionary
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
    // 创建一个字体描述对象 CTFontDescriptorRef
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    // 将字体描述对象放到一个 NSMutableArray 中
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);
    
    __block BOOL errorDuringDownload = NO;
    __block NSString *errorMessage = @"";
    
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
        
        double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
        
        if (state == kCTFontDescriptorMatchingDidBegin) {
            NSLog(@" 字体已经匹配 ");
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            if (!errorDuringDownload) {
                NSLog(@" 字体 %@ 下载完成 ", fontName);
                dispatch_async( dispatch_get_main_queue(), ^ {
                    // 可以在这里修改 UI 控件的字体
                    
                });
            }
        } else if (state == kCTFontDescriptorMatchingWillBeginDownloading) {
            NSLog(@" 字体开始下载 ");
        } else if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
            NSLog(@" 字体下载完成 ");
            dispatch_async( dispatch_get_main_queue(), ^ {
                // 可以在这里修改 UI 控件的字体
                
            });
        } else if (state == kCTFontDescriptorMatchingDownloading) {
            NSLog(@" 下载进度 %.0f%% ", progressValue);
        } else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            if (error != nil) {
                errorMessage = [error description];
            } else {
                errorMessage = @"ERROR MESSAGE IS NOT AVAILABLE!";
            }
            // 设置标志
            errorDuringDownload = YES;
            NSLog(@" 下载错误: %@", errorMessage);
        }
        
        return (BOOL)YES;
    });
}
//1. 判断该字体是否已经被下载下来了
+ (BOOL)rj_isFontDownloaded:(NSString *)fontName {
    UIFont* aFont = [UIFont fontWithName:fontName size:12.0];
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame
                  || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        return YES;
    } else {
        return NO;
    }
}
@end
