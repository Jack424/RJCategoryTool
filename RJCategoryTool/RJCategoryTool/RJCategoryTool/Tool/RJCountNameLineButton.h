//
//  RJCountNameLineButton.h
//  BMCityCon
//
//  Created by apple on 2018/12/19.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,RJCountNameLineButtonStyle) {
    RJCountNameLineButtonStyleDefault,
    RJCountNameLineButtonStyleImageButton
};
@interface RJCountNameLineButton : UIButton
- (instancetype)initWithFrame:(CGRect)frame style:(RJCountNameLineButtonStyle)style showLine:(BOOL)isShowLine;
- (instancetype)initWithFrame:(CGRect)frame style:(RJCountNameLineButtonStyle)style showLine:(BOOL)isShowLine clickBlock:(void(^)(RJCountNameLineButton *sender))clickBlock;

@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,strong)UILabel *topLable;

@property(nonatomic,strong)UILabel *bottomLable;

@property(nonatomic,strong)UIImageView *topImageView;
@end
