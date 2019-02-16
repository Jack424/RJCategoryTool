//
//  RJSureButton.m
//  BMCityCon
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import "RJSureButton.h"
#import "RJColorAndFont.h"

@implementation RJSureButton
-(instancetype)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = rj_kColor_ecbf24;
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.height/2;
}

@end
