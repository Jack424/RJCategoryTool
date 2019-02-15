//
//  UIView+GRJFrame.h
//  GRJTolCayFrwk
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GRJFrame)

/************      获取某些属性值           ***********/
@property(nonatomic, assign) CGFloat grj_left;
@property(nonatomic, assign) CGFloat grj_top;

@property(nonatomic, assign) CGFloat grj_width;
@property(nonatomic, assign) CGFloat grj_height;

@property(nonatomic, assign) CGFloat grj_centerX;
@property(nonatomic, assign) CGFloat grj_centerY;



@property(nonatomic, assign) CGFloat grj_right;
@property(nonatomic, assign) CGFloat grj_bottom;

@property(nonatomic, assign) CGPoint grj_origin;
@property(nonatomic, assign) CGSize grj_size;



/************      增加某些属性值           ***********/
- (void)grj_AddTop:(CGFloat)add;
- (void)grj_AddLeft:(CGFloat)add;
- (void)grj_AddWidth:(CGFloat)add;
- (void)grj_AddHeight:(CGFloat)add;



//descendant 后裔   返回自己或者是子View
- (UIView *)grj_descendantOrSelfWithClass:(Class)clazz;


//ancestor 祖先  先辈  返回自己或者是父View
- (UIView *)grj_ancestorOrSelfWithClass:(Class)clazz;


//移除所有的子控件
- (void)grj_removeAllSubviews;

- (UIViewController*)grj_viewController;

//找出对应Tag的View
- (instancetype)grj_subviewWithTag:(NSInteger)tag;

+ (UIViewAnimationOptions)grj_animationOptionsForCurve:(UIViewAnimationCurve)curve;





/******************************************************************************************/

/******************************************************************************************/
/**  设置圆角  */
- (void)rounded:(CGFloat)cornerRadius;

/**  设置圆角和边框  */
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**  设置边框  */
- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**   给哪几个角设置圆角  */
-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner;

/**  设置阴影  */
-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

- (UIViewController *)viewController;

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font;

/******************************************************************************************/

/******************************************************************************************/

-(void)rj_logSubviews;


@end
