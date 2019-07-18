//
//  RJTextLVTool.h
//  RJCategoryTool
//
//  Created by apple on 2019/7/18.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJTextLVTool : NSObject
/**
 * 设置文字间距
 */
+(NSMutableAttributedString *)rj_mutableAttributedPlaceStringWithString:(NSString *)string;

/**
 计算商品详情cell的高度
 
 @param string 文字
 @param font 字体大小
 @param addNum 增加的尺寸
 @return 文字高度
 */
+(CGFloat)rj_calculatorHeightWithString:(NSString *)string Font:(UIFont *)font Add:(CGFloat)addNum;


+ (UIBarButtonItem *)rj_itemWithBarButtonItem:(UIBarButtonItem *)barButtonItem;



//UITextView 限制文字输入的方法
+(BOOL)rj_textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text limitCount:(NSInteger)limitCount :(UILabel *)countLabel;
+(NSInteger)rj_textViewDidChange:(UITextView *)textView limitCount:(NSInteger)limitCount :(UILabel *)countLabel;



+(NSString *)rj_jobTimeWithbeginTime:(NSString * _Nonnull)beginTime endTime:(NSString * _Nonnull)endTime serviceDate:(NSString * _Nonnull)serviceDate;


@end

NS_ASSUME_NONNULL_END
