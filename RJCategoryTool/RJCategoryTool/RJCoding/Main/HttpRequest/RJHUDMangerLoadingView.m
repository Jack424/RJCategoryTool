//
//  RJHUDMangerLoadingView.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/17.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJHUDMangerLoadingView.h"
@interface RJHUDMangerLoadingView ()

@property (nonatomic, strong) UIView        *contentView;
@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) UILabel       *titleLabel;

@end

@implementation RJHUDMangerLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cover = NO;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@(CGPointMake(0.0, - 188.0)));//88
        make.top.equalTo(self.imageView.mas_top);
        make.left.equalTo(self.imageView.mas_left);
        make.right.equalTo(self.imageView.mas_right);
    }];
}

- (void)setCover:(BOOL)cover {
    _cover = cover;
    self.backgroundColor = self.cover ? rj_kColor_f3f6f6 : [UIColor clearColor];
    self.titleLabel.hidden = !self.cover;
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.cover) {
            make.bottom.equalTo(self.titleLabel.mas_bottom).priorityHigh();
        }
        else {
            make.bottom.equalTo(self.imageView.mas_bottom).priorityHigh();
        }
    }];
}

#pragma mark - Getter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@143.0);
            make.height.equalTo(@147.0);
            make.centerX.equalTo(@0.0);
        }];
        [_contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(1.0);
            make.centerX.equalTo(@0.0);
        }];
    }
    return _contentView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        UIImage *image = [UIImage animatedImageNamed:@"MokeyLoading_000"
                                            duration:1.0];
        _imageView.image = image;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textColor = rj_kColor_999999;
        _titleLabel.text = @"努力加载中...";
    }
    return _titleLabel;
}
@end
