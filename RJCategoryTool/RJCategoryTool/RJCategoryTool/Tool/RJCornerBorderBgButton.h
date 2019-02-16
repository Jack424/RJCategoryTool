//
//  RJCornerBorderBgButton.h
//  BMCityCon
//
//  Created by apple on 2018/12/20.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJCornerBorderBgButton : UIButton
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont bgColor:(UIColor *)bgColor isHaveBorder:(BOOL)isHaveBorder borderColor:(UIColor *)borderColor;
@end
