//
//  RJModuleEntranceCollectionViewCell.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJModuleEntranceCollectionViewCell.h"
@interface RJModuleEntranceCollectionViewCell()

@property (strong ,nonatomic) UIImageView *imageView;

@property (strong ,nonatomic) UILabel *label;

@end
@implementation RJModuleEntranceCollectionViewCell

-(void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    
    self.imageView.image = rj_IMAGE_NAMED(dataDict[@"image"]);
    self.label.text      = dataDict[@"title"];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView  = [[UIImageView alloc]init];
        [self addSubview:imageView];
        imageView.layer.cornerRadius = 20;
        imageView.clipsToBounds = YES;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(8);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        UILabel *label = [RJInitViewTool rj_initLabelWithSuperView:self text:@"微信支付" font:rj_kFont_24 textColor:rj_kColor_333333];
        label.font = [UIFont fontWithName:rj_kFontName size:rj_kValue_24];
        
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(imageView.mas_bottom).offset(8);
        }];
        
        self.imageView = imageView;
        self.label     = label;
    }
    return self;
}
@end
