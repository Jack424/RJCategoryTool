//
//  RJCountNameLineButton.m
//  BMCityCon
//
//  Created by apple on 2018/12/19.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import "RJCountNameLineButton.h"
#import "RJInitViewTool.h"
#import "Masonry.h"
#import "RJColorAndFont.h"
@interface RJCountNameLineButton()

@property(nonatomic,strong) void(^backBlock)(RJCountNameLineButton *sender);

@property(nonatomic,assign)RJCountNameLineButtonStyle style;
@property(nonatomic,assign)BOOL isShowLine;
@end
@implementation RJCountNameLineButton

- (instancetype)initWithFrame:(CGRect)frame style:(RJCountNameLineButtonStyle)style showLine:(BOOL)isShowLine{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        _isShowLine = isShowLine;
        [self addSubviews];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(RJCountNameLineButtonStyle)style showLine:(BOOL)isShowLine clickBlock:(void(^)(RJCountNameLineButton *sender))clickBlock{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        _isShowLine = isShowLine;
        [self addSubviews];
        [self addTarget:self action:@selector(my_click:) forControlEvents:UIControlEventTouchUpInside];
        self.backBlock = ^(RJCountNameLineButton *sender) {
            if (clickBlock) {
                clickBlock(sender);
            }
        };
    }
    return self;
}
-(void)addSubviews{
    self.backgroundColor = [UIColor whiteColor];
    switch (_style) {
        case RJCountNameLineButtonStyleDefault:
        {
            self.topLable = [RJInitViewTool rj_initLabelWithSuperView:self text:@"----" font:[UIFont systemFontOfSize:17] textColor:rj_kColor_333333];
        }
            break;
            
        default:
        {
            self.topImageView = [RJInitViewTool rj_initImageViewWithSuperView:self];
        }
            break;
    }
    self.bottomLable = [RJInitViewTool rj_initLabelWithSuperView:self text:@"----" font:[UIFont systemFontOfSize:13] textColor:rj_kColor_666666];
    self.lineView = [RJInitViewTool rj_initLineViewWithSuperView:self backgroundColor:rj_kColor_eeeeee];
    self.lineView.hidden = !_isShowLine;
}
-(void)my_click:(RJCountNameLineButton *)sender{
    if (self.backBlock) {
        self.backBlock(sender);
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    switch (_style) {
        case RJCountNameLineButtonStyleDefault:
        {
            [self.topLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_centerY).offset(-2);
                make.centerX.equalTo(self);
            }];
            [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_centerY).offset(2);
                make.centerX.equalTo(self);
            }];
        }
            break;
            
        default:
        {
            [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_centerY).offset(8);
                make.centerX.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
            [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_centerY).offset(15);
                make.centerX.equalTo(self);
            }];
        }
            break;
    }
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(0.5, 30));
        make.centerY.equalTo(self);
    }];
}


@end
