//
//  RJImageTextActionView.h
//  BMCityCon
//
//  Created by apple on 2019/1/10.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,RJImageTextActionViewType) {
    RJImageTextActionViewTypeCenter,//居中
    RJImageTextActionViewTypeLeft//靠左
};

NS_ASSUME_NONNULL_BEGIN

@interface RJImageTextActionView : UIView

@property(nonatomic,strong)NSString  *centerLabelText;

/**
 旧的初始化方法  子空间居中
 
 @param frame frame
 @param leftNormalImageName leftNormalImageName
 @param leftSeletedImageName leftSeletedImageName
 @param midText 中间的文字
 @param actionText 右边的需要点击的点击文字
 @param fontSize 文字大小
 @return self
 */
-(instancetype)initWithFrame:(CGRect)frame leftNormalImageName:(NSString *)leftNormalImageName leftSeletedImageName:(NSString *)leftSeletedImageName midText:(NSString *)midText actionText:(NSString *)actionText font:(CGFloat)fontSize;
/**
 新的初始化方法
 
 @param frame frame
 @param type RJImageTextActionViewType
 @param leftNormalImageName leftNormalImageName
 @param leftSeletedImageName leftSeletedImageName
 @param midText 中间的文字
 @param actionText 右边的需要点击的点击文字
 @param fontSize 文字大小
 @return self
 */
-(instancetype)initWithFrame:(CGRect)frame type:(RJImageTextActionViewType)type leftNormalImageName:(NSString *)leftNormalImageName leftSeletedImageName:(NSString *)leftSeletedImageName midText:(NSString *)midText actionText:(NSString *)actionText font:(CGFloat)fontSize;
/**
 左边按钮点击的回调
 */
@property(nonatomic,strong) void(^selectBlock)(UIButton *sender);

/**
 右边label的点击回调
 */
@property(nonatomic,strong) void(^labelSelectedBlock)(void);
@end

NS_ASSUME_NONNULL_END
