//
//  RJCornerBorderBgButton.m
//  BMCityCon
//
//  Created by apple on 2018/12/20.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import "RJCornerBorderBgButton.h"
@interface RJCornerBorderBgButton()
@property(nonatomic,assign)BOOL isHaveBorder;
@end
@implementation RJCornerBorderBgButton
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont bgColor:(UIColor *)bgColor isHaveBorder:(BOOL)isHaveBorder borderColor:(UIColor *)borderColor{
    self = [super initWithFrame:frame];
    if (self) {
        _isHaveBorder = isHaveBorder;
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        
        self.titleLabel.font = titleFont;
        self.backgroundColor = bgColor;
        
        if (isHaveBorder) {
            self.layer.borderWidth = 0.5;
            self.layer.borderColor = borderColor.CGColor;
        }
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //self.layer.cornerRadius = self.bounds.size.height/2;
    self.layer.cornerRadius = 5;
}
@end
