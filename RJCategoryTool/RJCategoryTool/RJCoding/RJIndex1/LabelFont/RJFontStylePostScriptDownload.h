//
//  RJFontStylePostScriptDownload.h
//  RJCategoryTool
//
//  Created by apple on 2019/7/18.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define rj_kFontName  @"DFWaWaSC-W5"
@interface RJFontStylePostScriptDownload : NSObject
+(void)rj_downLoadFont:(NSString *)fontName;
@end

NS_ASSUME_NONNULL_END
