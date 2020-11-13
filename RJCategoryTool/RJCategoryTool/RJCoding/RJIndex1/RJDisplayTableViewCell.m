//
//  RJDisplayTableViewCell.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/17.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJDisplayTableViewCell.h"

@implementation RJDisplayTableViewCell

-(void)rj_setTableViewCell{
    [super rj_setTableViewCell];
    
    UIImageView *imageV = [RJInitViewTool rj_initImageViewWithSuperView:self.contentView];
    _imageV = imageV;
    imageV.layer.cornerRadius = 10;
    imageV.clipsToBounds = YES;
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.width.mas_equalTo(imageV.mas_height);
    }];
    
    UILabel *bookLabel = [RJInitViewTool rj_initLabelWithSuperView:self text:@"Harry Potter" font:rj_kFont_36 textColor:rj_kColor_333333];
    [bookLabel setFont:[UIFont fontWithName:@"Zapfino" size:13]];
    [bookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageV.mas_right).offset(15);
        make.top.equalTo(imageV);
    }];
    
    UILabel *authorLabel = [RJInitViewTool rj_initLabelWithSuperView:self.contentView text:@"J. K. Rowling" font:rj_kFont_36 textColor:rj_kColor_333333];
    [authorLabel setFont:[UIFont fontWithName:@"Snell Roundhand" size:13]];
    [authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bookLabel.mas_right).offset(15);
        make.centerY.equalTo(bookLabel);
    }];
    
    
    UILabel *introductionLabel = [RJInitViewTool rj_initLabelWithSuperView:self.contentView text:@"Harry Potter is a series of seven fantasy novels written by the British author J. K. Rowling.The books chronicle the adventures of the adolescent wizard Harry Potter and his best friends Ron Weasley and Hermione Granger, all of whom are students at Hogwarts School of Witchcraft and Wizardry." font:rj_kFont_36 textColor:rj_kColor_333333];
    introductionLabel.numberOfLines = 0;
    [introductionLabel setFont:[UIFont fontWithName:@"Party LET" size:13]];
    [introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageV.mas_right).offset(15);
        make.top.equalTo(bookLabel.mas_bottom);
        make.right.equalTo(self.contentView).offset(-15);
    }];
}
@end
