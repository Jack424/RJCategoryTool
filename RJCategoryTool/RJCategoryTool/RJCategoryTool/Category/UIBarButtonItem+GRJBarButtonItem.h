//
//  UIBarButtonItem+GRJBarButtonItem.h
//  GRJTolCayFrwk
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GRJBarButtonItem)

// 快速创建UIBarButtonItem
+ (UIBarButtonItem *)item:(UIImage *)image highImage:(UIImage *)highImage target:( id)target action:(SEL)action;

+ (UIBarButtonItem *)item:(UIImage *)image selImage:(UIImage *)selImage target:( id)target action:(SEL)action;



+ (UIBarButtonItem *)item:(UIImage *)image highImageLimit:(UIImage *)highImage target:( id)target action:(SEL)action;


+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;


+ (UIBarButtonItem *)itemWithBarButtonItem:(UIBarButtonItem *)barButtonItem;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
