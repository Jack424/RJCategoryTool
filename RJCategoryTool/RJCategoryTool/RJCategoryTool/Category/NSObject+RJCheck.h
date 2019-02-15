//
//  NSObject+RJCheck.h
//  BMCityCon
//
//  Created by apple on 2018/12/20.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSObject (RJCheck)
+ (BOOL)rj_objIsEmpty:(id)object ;



/*
 * 获取View的父类控制器
 */
+ (UIViewController*)rj_getViewControllerFromView:(UIView *)view ;
/*
 * 获取View的导航控制器
 */
+ (UINavigationController*)rj_getNavigationControllerFromView:(UIView *)view ;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)rj_getCurrentVC;
@end
