//
//  RJInitViewTool.m
//  RJPrecious
//
//  Created by 易上云 on 2017/12/15.
//  Copyright © 2017年 GRJ. All rights reserved.
//

#import "RJInitViewTool.h"

@implementation RJInitViewTool
+(UILabel *)rj_initLabelWithSuperView:(UIView *)superView text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor{
    UILabel *label = [[UILabel alloc]init];
    label.font = font;
    label.textColor = textColor;
    label.text = text;
    [superView addSubview:label];
    return label;
}
+(UIImageView *)rj_initImageViewWithSuperView:(UIView *)superView{
    UIImageView *imageview = [[UIImageView alloc]init];
    [superView addSubview:imageview];
    return imageview;
}
+(UIView *)rj_initLineViewWithSuperView:(UIView *)superView backgroundColor:(UIColor *)backgroundColor{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = backgroundColor;
    [superView addSubview:lineView];
    return lineView;
}
+(UITextField *)rj_initTextFieldWithSuperView:(UIView *)superView textAlignment:(NSTextAlignment )textAlignment placeholder:(NSString *)placeholder font:(UIFont *)font{
    UITextField *textField = [[UITextField alloc]init];
    textField.textAlignment = textAlignment;
    textField.placeholder = placeholder;
    textField.font = font;
    [superView addSubview:textField];
    return textField;
}
+(UIButton *)rj_initSelectedButtonWithSuperView:(UIView *)superView normal:(NSString *)normalImageName selected:(NSString *)selectedImageName target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:button];
    return button;
}
+(UIButton *)rj_initImageButtonWithSuperView:(UIView *)superView normal:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:button];
    return button;
}
+(UIButton *)rj_initImageButtonWithSuperView:(UIView *)superView normal:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:button];
    return button;
}



//获取控制器
+ (UIViewController *)rj_getViewControllerFromView:(UIView *)view {
    for (UIView *next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



//获取导航控制器
+ (UINavigationController *)rj_getNavigationControllerFromView:(UIView *)view {
    for (UIView *next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)nextResponder;
        }
    }
    return nil;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)rj_getCurrentVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}

@end
