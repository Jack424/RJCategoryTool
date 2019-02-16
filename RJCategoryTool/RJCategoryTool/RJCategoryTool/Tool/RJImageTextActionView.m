//
//  RJImageTextActionView.m
//  BMCityCon
//
//  Created by apple on 2019/1/10.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import "RJImageTextActionView.h"
#import "Masonry.h"
#import "RJColorAndFont.h"
#import "RJMainMacros.h"
#import "RJInitViewTool.h"
@interface RJImageTextActionView()
@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UILabel  *centerLabel;
@property(nonatomic,strong)UILabel  *actionLabel;


@property(nonatomic,strong)NSString  *actionText;
@property(nonatomic,assign)CGFloat   fontSize;

@property(nonatomic,assign)RJImageTextActionViewType type;
@end

@implementation RJImageTextActionView

-(void)setCenterLabelText:(NSString *)centerLabelText{
    self.centerLabel.text = centerLabelText;
    
    if (self.type==RJImageTextActionViewTypeCenter) {
        CGFloat contextWidth = (centerLabelText.length+_actionText.length)*_fontSize+20;
        [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset((rj_kScreenWidth-contextWidth)/2);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
    
}
-(instancetype)initWithFrame:(CGRect)frame leftNormalImageName:(NSString *)leftNormalImageName leftSeletedImageName:(NSString *)leftSeletedImageName midText:(NSString *)midText actionText:(NSString *)actionText font:(CGFloat)fontSize{
    if (self = [super initWithFrame:frame]) {
        CGFloat contextWidth = (midText.length+actionText.length)*fontSize+20;
        [self setSubViewsLeftNormalImageName:leftNormalImageName leftSeletedImageName:leftSeletedImageName midText:midText actionText:actionText font:fontSize];
        [self layoutSubviewsWithContextWidth:contextWidth type:RJImageTextActionViewTypeCenter];
        _type=RJImageTextActionViewTypeCenter;
        _actionText = actionText;
        _fontSize = fontSize;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame type:(RJImageTextActionViewType)type leftNormalImageName:(NSString *)leftNormalImageName leftSeletedImageName:(NSString *)leftSeletedImageName midText:(NSString *)midText actionText:(NSString *)actionText font:(CGFloat)fontSize{
    if (self = [super initWithFrame:frame]) {
        CGFloat contextWidth = (midText.length+actionText.length)*fontSize+20;
        [self setSubViewsLeftNormalImageName:leftNormalImageName leftSeletedImageName:leftSeletedImageName midText:midText actionText:actionText font:fontSize];
        [self layoutSubviewsWithContextWidth:contextWidth type:type];
        _type=type;
        _actionText = actionText;
        _fontSize = fontSize;
    }
    return self;
}
-(void)layoutSubviewsWithContextWidth:(CGFloat)contextWidth type:(RJImageTextActionViewType)type {
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (type==RJImageTextActionViewTypeCenter) {
            make.left.equalTo(self).offset((rj_kScreenWidth-contextWidth)/2);
        }else{
            make.left.equalTo(self);
        }
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftButton.mas_right).offset(2);
        make.centerY.equalTo(self);
    }];
    [self.actionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerLabel.mas_right).offset(2);
        make.centerY.equalTo(self);
    }];
}
-(void)setSubViewsLeftNormalImageName:(NSString *)leftNormalImageName leftSeletedImageName:(NSString *)leftSeletedImageName midText:(NSString *)midText actionText:(NSString *)actionText font:(CGFloat)fontSize{
    self.leftButton = [RJInitViewTool rj_initSelectedButtonWithSuperView:self normal:leftNormalImageName selected:leftSeletedImageName target:self action:@selector(leftAction:)];
    self.centerLabel = [RJInitViewTool rj_initLabelWithSuperView:self text:midText font:[UIFont systemFontOfSize:fontSize] textColor:rj_kColor_666666];
    self.actionLabel = [RJInitViewTool rj_initLabelWithSuperView:self text:actionText font:[UIFont systemFontOfSize:fontSize] textColor:[UIColor colorWithHexString:@"#3A77FB"]];
    self.actionLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelSelected)];
    [self.actionLabel addGestureRecognizer:tap];
}
-(void)leftAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (_selectBlock) {
        _selectBlock(sender);
    }
}
-(void)labelSelected{
    if (_labelSelectedBlock) {
        _labelSelectedBlock();
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}
@end
