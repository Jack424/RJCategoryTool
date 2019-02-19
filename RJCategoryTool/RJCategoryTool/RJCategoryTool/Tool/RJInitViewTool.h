//
//  RJInitViewTool.h
//  RJPrecious
//
//  Created by 易上云 on 2017/12/15.
//  Copyright © 2017年 GRJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RJInitViewTool : NSObject
+(UILabel *)rj_initLabelWithSuperView:(UIView *)superView text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;

+(UIImageView *)rj_initImageViewWithSuperView:(UIView *)superView;

+(UIView *)rj_initLineViewWithSuperView:(UIView *)superView backgroundColor:(UIColor *)backgroundColor;
+(UITextField *)rj_initTextFieldWithSuperView:(UIView *)superView textAlignment:(NSTextAlignment )textAlignment placeholder:(NSString *)placeholder font:(UIFont *)font;

+(UIButton *)rj_initSelectedButtonWithSuperView:(UIView *)superView normal:(NSString *)normalImageName selected:(NSString *)selectedImageName target:(id)target action:(SEL)action;
+(UIButton *)rj_initImageButtonWithSuperView:(UIView *)superView normal:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action;

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
