//
//  RJRootVCTool.m
//  BMCityCon
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import "RJRootVCTool.h"
#import "RJNewFeatureCollectionViewController.h"

@implementation RJRootVCTool

+(void)rj_rootVCToolHomeVc:(NSString *)homeVCValue{
    rjHomeVCKeySave(homeVCValue);
}
/**
 *  选择窗口的根控制器
 *
 *  @return 当前窗口的根控制器
 */
+ (UIViewController *)chooseRootVC {
    //创建TabBarVC
    //判断版本
    //获取当前软件的版本
    //NSString *curVersion =  [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *curVersion =  [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //与上一次保存的版本进行对比
    NSString *preVer = [[NSUserDefaults standardUserDefaults] objectForKey:GRJVersion];
    
    if ([curVersion isEqualToString:preVer]) {
        //如果相同,进入程序的主框架
        UIViewController *tabBarVc = [NSClassFromString(rjHomeVC) new];
        return tabBarVc;
    }else {
        //如果不同,进入新特性,保存当前版本
        RJNewFeatureCollectionViewController *newFeatureVC = [[RJNewFeatureCollectionViewController alloc] init];
        newFeatureVC.collectionView.backgroundColor = [UIColor greenColor];
        
        //保存当前版本
        //[[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:GRJVersion];
        return newFeatureVC;
    }
}

@end
