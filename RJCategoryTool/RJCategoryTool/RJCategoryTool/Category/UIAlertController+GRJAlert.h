//
//  UIAlertController+GRJAlert.h
//  HobayCn
//
//  Created by 易上云 on 2017/5/27.
//  Copyright © 2017年 Yi Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^alertSureBlock)(void);

typedef void(^leftAlertSureBlock)(void);

typedef void(^rightAlertSureBlock)(void);

@interface UIAlertController (GRJAlert)
//设置确定按钮
+(void)ShowAlertWithViewController:(UIViewController *)viewController Title:( NSString *)title message:( NSString *)message actionTitle:( NSString *)actionTitle sure:(alertSureBlock)sureAction;


//设置左右两边按钮
+(void)ShowAlertWithViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message leftActionTitle:(NSString *)leftActionTitle  rightActionTitle:(NSString *)rightActionTitle leftAction:(leftAlertSureBlock)leftAction rightAction:(rightAlertSureBlock)rightAction;


//只有一个按钮
+(void)ShowAlertOneWithViewController:(UIViewController *)viewController Title:( NSString *)title message:( NSString *)message actionSureTitle:( NSString *)actionTitle sure:(alertSureBlock)sureAction;

//带有一个输入框
+(void)ShowAlertTextFieldWithViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message  placeholdStr:(NSString *)placeholdStr actionTitle:(NSString *)actionTitle sure:(void(^)(NSString *text))sureAction;

@end
