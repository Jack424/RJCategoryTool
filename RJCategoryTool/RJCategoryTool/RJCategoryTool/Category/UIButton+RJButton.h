//
//  UIButton+RJButton.h
//  BMCityCon
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (RJButton)
/*
 *    倒计时按钮
 *    @param timeLine  倒计时总时间
 *    @param title     还没倒计时的title
 *    @param subTitle  倒计时的子名字 如：时、分
 *    @param mColor    还没倒计时的颜色
 *    @param color     倒计时的颜色
 */

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;


- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countColor:(UIColor *)color TimeOut:(void(^)(void))success;
@end

NS_ASSUME_NONNULL_END
