//
//  UITextField+GRJTextField.m
//  GRJTolCayFrwk
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 Global Barter. All rights reserved.
//

#import "UITextField+GRJTextField.h"

#import <objc/message.h>

@implementation UITextField (GRJTextField)



- (void)shake {
    CAKeyframeAnimation *keyAn =
    [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyAn setDuration:0.5f];
    NSArray *array = [[NSArray alloc]
                      initWithObjects:[NSValue valueWithCGPoint:CGPointMake(self.center.x,
                                                                            self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x - 5,
                                                            self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x + 5,
                                                            self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x,
                                                            self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x - 5,
                                                            self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x + 5,
                                                            self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x,
                                                            self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x - 5,
                                                            self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x + 5,
                                                            self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x,
                                                            self.center.y)],
                      nil];
    [keyAn setValues:array];
    
    NSArray *times =
    [[NSArray alloc] initWithObjects:[NSNumber numberWithFloat:0.1f],
     [NSNumber numberWithFloat:0.2f],
     [NSNumber numberWithFloat:0.3f],
     [NSNumber numberWithFloat:0.4f],
     [NSNumber numberWithFloat:0.5f],
     [NSNumber numberWithFloat:0.6f],
     [NSNumber numberWithFloat:0.7f],
     [NSNumber numberWithFloat:0.8f],
     [NSNumber numberWithFloat:0.9f],
     [NSNumber numberWithFloat:1.0f], nil];
    [keyAn setKeyTimes:times];
    [self.layer addAnimation:keyAn forKey:@"Shark"];
}



/***************************************************************************/

+ (void)load
{
    // 获取方法实现
    Method  setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method  setXmg_placeholderMethod = class_getInstanceMethod(self, @selector(setXMG_placeholder:));
    method_exchangeImplementations(setPlaceholderMethod, setXmg_placeholderMethod);
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 把属性保存到系统的类 runtime动态添加属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    
    if (placeholderColor) {
        placeholderLabel.textColor = placeholderColor;
    }else{
        placeholderLabel.textColor = rj_kColor_999999;//[UIColor colorWithWhite:0.7 alpha:0.7];
    }
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

// 设置占位文字并且还要设置占位文字颜色
- (void)setXMG_placeholder:(NSString *)placeholder
{
    [self setXMG_placeholder:placeholder];
    
    self.placeholderColor = self.placeholderColor;
    
}

/***************************************************************************/




@end
