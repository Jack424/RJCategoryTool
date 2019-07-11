//
//  RTRootNavigationController+RTRootSetting.m
//  BMCityCon
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import "RTRootNavigationController+RTRootSetting.h"
#import <objc/runtime.h>


@implementation RTRootNavigationController (RTRootSetting)
//设置导航栏  文字属性 以及 分割线
+ (void)load {
    //UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.titleTextAttributes = @{
                                NSFontAttributeName: rj_kFont_36,
                                NSForegroundColorAttributeName: [UIColor blackColor]
                                };
    [bar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#ffffff"]] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage imageWithColor:rj_kColor_dddddd size:CGSizeMake(rj_kScreenWidth, 0.5)]];
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pushViewController:animated:)),
                                   class_getInstanceMethod(self, @selector(hb_pushViewController:animated:)));
}
//push时隐藏tabbar
- (void)hb_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [self hb_pushViewController:viewController animated:animated];
}

@end
