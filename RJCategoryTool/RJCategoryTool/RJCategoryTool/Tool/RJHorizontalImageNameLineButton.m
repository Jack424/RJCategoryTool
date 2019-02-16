//
//  RJHorizontalImageNameLineButton.m
//  BMCityCon
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import "RJHorizontalImageNameLineButton.h"
#import "RJInitViewTool.h"
#import "RJColorAndFont.h"
#import "Masonry.h"

@interface RJHorizontalImageNameLineButton()

@property(nonatomic,strong) void(^backBlock)(void);
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,assign)BOOL isShowLine;
@end
@implementation RJHorizontalImageNameLineButton

- (instancetype)initWithFrame:(CGRect)frame showLine:(BOOL)isShowLine{
    self = [super initWithFrame:frame];
    if (self) {
        _isShowLine = isShowLine;
        [self addSubviews];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame showLine:(BOOL)isShowLine clickBlock:(void(^)(void))clickBlock{
    self = [super initWithFrame:frame];
    if (self) {
        _isShowLine = isShowLine;
        [self addSubviews];
        [self addTarget:self action:@selector(my_click:) forControlEvents:UIControlEventTouchUpInside];
        self.backBlock = ^{
            if (clickBlock) {
                clickBlock();
            }
        };
    }
    return self;
}
-(void)addSubviews{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = rj_kFont_22;
    [self setTitleColor:rj_kColor_666666 forState:UIControlStateNormal];
    self.imageEdgeInsets = UIEdgeInsetsMake(-5, -15, -5, 0);
    
    self.lineView = [RJInitViewTool rj_initLineViewWithSuperView:self backgroundColor:rj_kColor_eeeeee];
    self.lineView.hidden = !_isShowLine;
}
-(void)my_click:(UIButton *)sender{
    if (self.backBlock) {
        self.backBlock();
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.mas_centerY).offset(5);
//        make.centerX.equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
//    [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_centerY).offset(15);
//        make.centerX.equalTo(self);
//    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(0.5, 30));
        make.centerY.equalTo(self);
    }];
}

@end
