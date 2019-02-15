//
//  UIView+GRJFrame.m
//  GRJTolCayFrwk
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 Global Barter. All rights reserved.
//

#import "UIView+GRJFrame.h"

@implementation UIView (GRJFrame)



/************      获取某些属性值           ***********/


//1 x
-(CGFloat)grj_left{
    return self.frame.origin.x;
}
-(void)setGrj_left:(CGFloat)grj_left{
    CGRect frame = self.frame;
    frame.origin.x = grj_left;
    self.frame = frame;
}


//2 y
-(CGFloat)grj_top{
    return self.frame.origin.y;
}

-(void)setGrj_top:(CGFloat)grj_top{
    CGRect frame = self.frame;
    frame.origin.y = grj_top;
    self.frame = frame;
}


//3 width
-(CGFloat)grj_width{
    return self.frame.size.width;
}

-(void)setGrj_width:(CGFloat)grj_width{
    CGRect frame = self.frame;
    frame.size.width = grj_width;
    self.frame = frame;
}


//4 height
-(CGFloat)grj_height{
    return self.frame.size.height;
}

-(void)setGrj_height:(CGFloat)grj_height{
    CGRect frame = self.frame;
    frame.size.height = grj_height;
    self.frame = frame;
}

//5 centerX
-(CGFloat)grj_centerX{
    return self.center.x;
}

-(void)setGrj_centerX:(CGFloat)grj_centerX{
    CGPoint center = self.center;
    center.x = grj_centerX;
    self.center = center;
}


//6 centerY
-(CGFloat)grj_centerY{
    return self.center.y;
}

-(void)setGrj_centerY:(CGFloat)grj_centerY{
    CGPoint center = self.center;
    center.y = grj_centerY;
    self.center = center;
}


//7 right
-(CGFloat)grj_right{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setGrj_right:(CGFloat)grj_right{
    CGRect frame = self.frame;
    frame.origin.x = grj_right - frame.size.width;
    self.frame = frame;
}

//8 bottom
-(CGFloat)grj_bottom{
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setGrj_bottom:(CGFloat)grj_bottom{
    CGRect frame = self.frame;
    frame.origin.y = grj_bottom - frame.size.height;
    self.frame = frame;
}

//9 origin
-(CGPoint)grj_origin{
    return self.frame.origin;
}

-(void)setGrj_origin:(CGPoint)grj_origin{
    CGRect frame = self.frame;
    frame.origin = grj_origin;
    self.frame = frame;
}

//10 size
-(CGSize)grj_size{
    return self.frame.size;
}
-(void)setGrj_size:(CGSize)grj_size{
    CGRect frame = self.frame;
    frame.size = grj_size;
    self.frame = frame;
}






/************      增加某些属性值           ***********/
-(void)grj_AddTop:(CGFloat)add{
    CGRect frame = self.frame;
    frame.origin.y += add;
    self.frame = frame;
}
-(void)grj_AddLeft:(CGFloat)add{
    CGRect frame = self.frame;
    frame.origin.x += add;
    self.frame = frame;
}

-(void)grj_AddWidth:(CGFloat)add{
    CGRect frame = self.frame;
    frame.size.width += add;
    self.frame = frame;
}
-(void)grj_AddHeight:(CGFloat)add{
    CGRect frame = self.frame;
    frame.size.height += add;
    self.frame = frame;
}



//descendant 后裔   返回自己或者是子View
-(UIView *)grj_descendantOrSelfWithClass:(Class)clazz{
    if ([self isKindOfClass:clazz]) {
        return self;
    }
    
    for (UIView *child in self.subviews) {
        UIView *it = [child grj_descendantOrSelfWithClass:clazz];
        if (it)
            return it;
    }
    
    return nil;
}

//ancestor 祖先  先辈  返回自己或者是父View
-(UIView *)grj_ancestorOrSelfWithClass:(Class)clazz{
    if ([self isKindOfClass:clazz]) {
        return self;
    }else if (self.subviews){
        return [self.superview grj_ancestorOrSelfWithClass:clazz];
    }else{
        return nil;
    }
}

//移除所有的子控件
-(void)grj_removeAllSubviews{
    while (self.subviews.count) {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}


-(UIViewController *)grj_viewController{
    
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//找出对应Tag的View
- (instancetype)grj_subviewWithTag:(NSInteger)tag {
    for(UIView *view in [self subviews]){
        if(view.tag == tag){
            return view;
        }
    }
    return nil;
}

//ease 慢 curve 曲线

/*
 
typedef NS_OPTIONS(NSUInteger, UIViewAnimationOptions) {
 
    //1
    UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
    //提交动画的时候布局子控件，表示子控件将和父控件一同动画。
 
    UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
    //动画时允许用户交流，比如触摸
 
    UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
    //从当前状态开始动画
 
    UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
    //动画无限重复
 
    UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
    //执行动画回路,前提是设置动画无限重复
 
    UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
    //忽略外层动画嵌套的执行时间
 
    UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
    //忽略外层动画嵌套的时间变化曲线
 
    UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
    //通过改变属性和重绘实现动画效果，如果key没有提交动画将使用快照
 
    UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
    //用显隐的方式替代添加移除图层的动画效果
 
    UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type
    //忽略嵌套继承的选项
 
 
    //2 时间函数曲线相关
    UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
    //时间曲线函数，由慢到快到慢
    UIViewAnimationOptionCurveEaseIn               = 1 << 16,
    //时间曲线函数，由慢到特别快
    UIViewAnimationOptionCurveEaseOut              = 2 << 16,
    //时间曲线函数，由快到慢
    UIViewAnimationOptionCurveLinear               = 3 << 16,
    //时间曲线函数，匀速
 
 
    //3 转场动画相关的
    UIViewAnimationOptionTransitionNone            = 0 << 20, // default
    //无转场动画
    UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
    //转场从左翻转
    UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
    //转场从右翻转
    UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
    //上卷转场
    UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
    //下卷转场
    UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
    //转场交叉消失
    UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
    //转场从上翻转
    UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
    //转场从下翻转
} NS_ENUM_AVAILABLE_IOS(4_0);

 */

+ (UIViewAnimationOptions)grj_animationOptionsForCurve:(UIViewAnimationCurve)curve {
    switch (curve) {
        case UIViewAnimationCurveEaseInOut://开始和结束的时候慢
            return UIViewAnimationOptionCurveEaseInOut;
            break;
        case UIViewAnimationCurveEaseIn://开始的时候慢
            return UIViewAnimationOptionCurveEaseIn;
            break;
        case UIViewAnimationCurveEaseOut://结束的时候慢
            return UIViewAnimationOptionCurveEaseOut;
            break;
        case UIViewAnimationCurveLinear: //匀速
            return UIViewAnimationOptionCurveLinear;
            break;
    }
    
    return kNilOptions;
}



/******************************************************************************************/

/******************************************************************************************/
#pragma mark - layer
- (void)rounded:(CGFloat)cornerRadius {
    [self rounded:cornerRadius width:0 color:nil];
}

- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor {
    [self rounded:0 width:borderWidth color:borderColor];
}

- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}


-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    //给Cell设置阴影效果
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
}


#pragma mark - base
- (UIViewController *)viewController {
    
    id nextResponder = [self nextResponder];
    while (nextResponder != nil) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)nextResponder;
            return vc;
        }
        nextResponder = [nextResponder nextResponder];
    }
    return nil;
}

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

-(void)rj_logSubviews{
    for (UIView *view in self.subviews) {
        NSLog(@"%@",view);
    }
}


/******************************************************************************************/

/******************************************************************************************/

@end





