//
//  RJBaseModalViewController.h
//  RJCategoryTool
//
//  Created by apple on 2019/7/18.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJBaseModalViewController : UIViewController
/**
 半透明背景颜色RGBA 默认 [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
 */
@property(nonatomic,strong)UIColor *backViewColor;//半透明背景颜色RGBA 默认
/**
 开始动画结束后的回调
 */
@property(nonatomic,strong)void(^appearAnimateCompletion)(void);

/**
 是否点击背景dismiss, 默认为NO
 */
@property(nonatomic,assign)BOOL isCancelBackDismiss;

/**
 dismiss
 */
-(void)dismissThisViewC:(void (^)(void))completion;
-(void)dismissThisViewC;

/**
 点击背景或者点击X号关闭回调(默认)
 */
@property(nonatomic,strong)void(^dismissComplete)(void);
/**
 消失时候动画 调用 [super rj_disappearAnimate];
 */
-(void)rj_disappearAnimate;

/**
 开始时候动画 调用 [super rj_appearAnimate];
 */
-(void)rj_appearAnimate;
@end

NS_ASSUME_NONNULL_END
