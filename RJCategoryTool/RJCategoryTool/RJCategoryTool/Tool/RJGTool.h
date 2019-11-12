//
//  RJGTool.h
//  RJCategoryTool
//
//  Created by JinTian on 2019/11/12.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJGTool : NSObject
//UITextView 限制文字输入的方法
+(BOOL)rjg_textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text limitCount:(NSInteger)limitCount :(UILabel *)countLabel;
+(NSInteger)rjg_textViewDidChange:(UITextView *)textView limitCount:(NSInteger)limitCount :(UILabel *)countLabel;
/* example
-(BOOL)rjg_textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return [RJBMTool textView:textView shouldChangeTextInRange:range replacementText:text limitCount:self.count :self.countStringL];
}
-(void)rjg_textViewDidChange:(UITextView *)textView{
    [RJBMTool textViewDidChange:textView limitCount:self.count :self.countStringL];
}
*/

//关键字改变颜色字体
+ (NSMutableAttributedString *)rjg_setAllText:(NSString *)allStr andSpcifiStr:(NSString *)keyWords withColor:(UIColor *)color specifiStrFont:(UIFont *)font;
+ (NSAttributedString *)rjg_colorAttributeString:(NSString *)sourceString sourceSringColor:(UIColor *)sourceColor sourceFont:(UIFont *)sourceFont keyWordArray:(NSArray<NSString *> *)keyWordArray keyWordColor:(UIColor *)keyWordColor keyWordFont:(UIFont *)keyWordFont;



/**
 打印一个类中所有的属性名  包含私有属性

 @param className 类名
 */
+(void)rjg_logAllPropertyFromClass:(NSString *)className;
/**
 打印一个类中所有的方法名
 
 @param className 类名
 */
+(void)rjg_logAllMethodFromClass:(NSString *)className;

//放大并保持
+(CABasicAnimation *)rjg_transformScaleState;
//Y轴位移
+(CABasicAnimation *)rjg_transformTranslationY;
//Z轴旋转
+(CABasicAnimation *)rjg_transformRotationZ;
//放大效果，并回到原位
+(CABasicAnimation *)rjg_transformScale;

+(CABasicAnimation *)rjg_randomTransform;

/**
 改变文字行间距 段首缩进
 
 @param string 要改变的文字
 @param lineSpace 行间距
 @param firstLine 段首缩进距离(26大约2个字符)
 @return 富文本
 */
+(NSAttributedString *)rjg_changeLabelLineSpace:(NSString *)string withLineSpace:(CGFloat)lineSpace withFirstLineHeadIndent:(CGFloat)firstLine;
@end

NS_ASSUME_NONNULL_END
