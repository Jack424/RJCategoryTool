//
//  RJRootVCTool.h
//  BMCityCon
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import <Foundation/Foundation.h>
#define GRJVersion @"curVersion"
NS_ASSUME_NONNULL_BEGIN

@interface RJRootVCTool : NSObject

#define rjHomeVCKey          @"HomeVCKey"

#define rjHomeVCKeySave(key) [[NSUserDefaults standardUserDefaults]setObject:key forKey:rjHomeVCKey];

#define rjHomeVC             [[NSUserDefaults standardUserDefaults]objectForKey:rjHomeVCKey]

+(void)rj_rootVCToolHomeVc:(NSString *)homeVCValue;
/**
 *  选择窗口的根控制器
 *
 *  @return 当前窗口的根控制器
 */
+ (UIViewController *)chooseRootVC;

@end

NS_ASSUME_NONNULL_END
