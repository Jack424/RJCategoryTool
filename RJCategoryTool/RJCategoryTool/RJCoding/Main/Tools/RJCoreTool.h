//
//  RJCoreTool.h
//  RJPrecious
//
//  Created by 易上云 on 2017/10/25.
//  Copyright © 2017年 GRJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJCoreTool : NSObject

+(UIBezierPath *)rj_bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
+(UIBezierPath *)rj_bezierPathMoveAndAddLineToPoint;
+(UIBezierPath *)rj_bezierPathWithOvalInRect:(CGRect)rect;
+(UIBezierPath *)rj_bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
+(UIView *)rj_setUpSubViewsWithController:(UIViewController *)controller :(NSArray *)buttonTitleArray action:(SEL)action;



//UITextView 限制文字输入的方法
+(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text limitCount:(NSInteger)limitCount;
+(NSInteger)textViewDidChange:(UITextView *)textView limitCount:(NSInteger)limitCount;

/**
 打印一个类中所有的属性名  包含私有属性

 @param className 类名
 */
+(void)rj_logAllPropertyFromClass:(NSString *)className;
/**
 打印一个类中所有的方法名
 
 @param className 类名
 */
+(void)rj_logAllMethodFromClass:(NSString *)className;

//放大并保持
+(CABasicAnimation *)rj_transformScaleState;
//Y轴位移
+(CABasicAnimation *)rj_transformTranslationY;
//Z轴旋转
+(CABasicAnimation *)rj_transformRotationZ;
//放大效果，并回到原位
+(CABasicAnimation *)rj_transformScale;

+(CABasicAnimation *)rj_randomTransform;

/**
 计算商品详情cell的高度
 
 @param string 文字
 @param font 字体大小
 @param addNum 增加的尺寸
 @return 文字高度
 */
+(CGFloat)calculatorHeightWithString:(NSString *)string Font:(UIFont *)font Add:(CGFloat)addNum;

+(CGFloat)calculatorAuctionMineHeightWithString:(NSString *)string Font:(UIFont *)font Add:(CGFloat)addNum;


/**
 比较两个时间的大小
 
 @param date01 sdfds
 @param date02 fsdf
 @return i
 */
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02;


/**
 
 某个时间 往后面推移或是往前面推移 年 月 日
 
 @param date 给定的时间
 @param year 推移多少年
 @param month 推移多少个月
 @param day 推移多少天
 @return 返回 推移后的字符串
 */
+(NSString *)maxExpireTime:(NSDate *)date withYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day;


/**
 label 富文本编辑(改变指定文字 颜色 大小)
 
 @param text 目标 label
 @param stringArray  要改变的文字数组
 @param font 字体大小
 @param color 文字颜色
 */
+(NSAttributedString *)changeTextColor:(NSString *)text withChangeTextArray:(NSArray *)stringArray withFont:(UIFont *)font withColor:(UIColor *)color;

/**
 改变文字颜色 (单个改变)
 
 @param text 目标文字
 @param changeText 要改变的文字
 @param font 字体大小
 @param color 文字颜色
 @return 富文本文字
 */
+(NSMutableAttributedString *)changeTextColor:(NSString *)text withChangeText:(NSString *)changeText withFont:(UIFont*)font withColor:(UIColor *)color;

/**
 改变文字行间距 段首缩进
 
 @param string 要改变的文字
 @param lineSpace 行间距
 @param firstLine 段首缩进距离(26大约2个字符)
 @return 富文本
 */
+(NSAttributedString *)changeLabelLineSpace:(NSString *)string withLineSpace:(CGFloat)lineSpace withFirstLineHeadIndent:(CGFloat)firstLine;
@end
