//
//  NSString+RJString.h
//  BMCityCon
//
//  Created by apple on 2018/12/20.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (RJString)
/**
 是否为空
 
 @param string 文本
 @return TRUE OR FALSE
 */
+ (BOOL)rj_stringIsEmpty:(NSString *)string;


/**
 当前字符串是否只包含空白字符和换行符
 
 @param string 文本
 @return TRUE OR FALSE
 */
+ (BOOL)isWhitespaceAndNewline:(NSString *)string;

/**
 以给定字符串开始,忽略大小写
 
 @param string 文本
 @return TRUE OR FALSE
 */
- (BOOL)hasPrefixIgnoreCase:(NSString *)string;

/**
 以指定条件判断字符串是否以给定字符串开始
 
 @param string 文本
 @param compareOptions 判断条件
 @return TRUE OR FALSE
 */
- (BOOL)hasPrefixIgnoreCase:(NSString *)string
                    options:(NSStringCompareOptions)compareOptions;

/**
 判断文本是否是string结尾
 
 @param string 文本
 @return TRUE OR FALSE
 */
- (BOOL)hasSuffixIgnoreCase:(NSString *)string;

/**
 以指定条件判断字符串是否以给定字符串结尾
 
 @param string 文本
 @param compareOptions 判断条件
 @return TRUE OR FALSE
 */
- (BOOL)hasSuffixIgnoreCase:(NSString *)string
                    options:(NSStringCompareOptions)compareOptions;

/**
 包含给定的字符串, 忽略大小写
 
 @param string 文本
 @return TRUE OR FALSE
 */
- (BOOL)containsStringIgnoreCase:(NSString *)string;

/**
 以指定条件判断是否包含给定的字符串
 
 @param string 文本
 @param compareOptions 判断条件
 @return TRUE OR FALSE
 */
- (BOOL)containsStringIgnoreCase:(NSString *)string
                         options:(NSStringCompareOptions)compareOptions;

/**
 判断字符串是否相同，忽略大小写
 
 @param string 文本
 @return TRUE OR FALSE
 */
- (BOOL)isEqualToStringIgnoreCase:(NSString *)string;

/**
 比较版本"."为分割符 分段对比 (self > version) = YES
 if ([NSString isEmpty:version]) {
 return YES;
 }
 
 @param version 版本
 @return TRUE OR FALSE
 */
- (BOOL)compareVerison:(NSString *)version;

@end

/**
 文本修饰
 */
@interface NSString (Modify)

/**
 去除字符串前后的空白
 
 @return 修改后的文本
 */
- (NSString *)trim;

/**
 去除文本中的"-"
 
 @return 修改后的文本
 */
- (NSString *)removeMinus;

/**
 去除文本中的空格
 
 @return 修改后的文本
 */
- (NSString *)removeWhiteSpace;

/**
 去除文本中的空白行
 
 @return 修改后的文本
 */
- (NSString *)removeNewLine;

/**
 去除文本中的空白行和空格
 
 @return 修改后的文本
 */
- (NSString *)removeWhitespaceAndNewline;

/**
 添加人民币符号(￥xxx)
 
 @return 添加后的文本
 */
- (NSString *)addRMBSymbol;

/**
 获取数字和字母随机数
 
 @param lenght 随机数的位数
 @return 结果
 */
+ (NSString *)getRandomString:(NSUInteger)lenght;

/**
 md5加密
 
 @return 加密后的结果
 */
- (NSString *)md5;

@end

/**
 文本URL相关
 */
@interface NSString (URL)

/**
 验证是否是URL字符串
 
 @return TRUE OR FALSE
 */
- (BOOL)URLValidation;

/**
 URL字符串进行编码
 
 @return 编码后的URL字符串
 */
- (NSString *)URLStringEncoding;

/**
 URL字符串进行解码
 
 @return 解码后的URL字符串
 */
- (NSString *)URLStringDecoding;

/**
 获取URL字符串的参数
 
 @return 字典形式的URL参数
 */
- (NSDictionary *)URLParameter;

@end

@interface NSString (HCCommon)

#pragma mark - NSDecimalNumber
/**
 数字字符串转2位小数点NSDecimalNumber
 
 @return NSDecimalNumber
 */
- (NSDecimalNumber *)toTwoPointDecimalNumber;

/**
 数字字符串转NSDecimalNumber
 
 @return NSDecimalNumber
 */
- (NSDecimalNumber *)toDecimalNumber;

//获取文本Size
- (CGSize)textSizeIn:(CGSize)size
                font:(UIFont *)font;
- (CGSize)textSizeIn:(CGSize)size
                font:(UIFont *)font
           breakMode:(NSLineBreakMode)breakMode
               align:(NSTextAlignment)alignment;
- (CGSize)sizeWithFont:(UIFont *)font
              maxWidth:(CGFloat)width;

#pragma mark - GRJString
/**
 *  是否是正确的登陆密码
 */
- (BOOL)isLoginPassword;

/**
 处理手机号带****
 135******78
 @param string 传入未处理的手机号\
 @return 返回处理后的手机号
 */
+ (NSString *)phoneNumberDealWithString:(NSString *)string;

/**
 判断是否是身份证号
 
 @param identityString 传入用户输入的身份证号
 @return 判断是否是身份证号
 */
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString ;

/**
 用户名隐藏设置
 **杰
 @param string 1
 @return 2
 */
+ (NSString *)userNameDealWithString:(NSString *)string;

/**
 *  判断是否是手机号  规则:1开头  11位
 *  phoneNumber: 手机号
 */
+ (BOOL)isMobilePhoneNumber:(NSString *)phoneNumber;

//计算距离 返回有单位
+ (NSString *)countDistance:(NSNumber *)diatance;

/**
 截取两个字符串中间的字符串
 
 @param string 要处理的字符串
 @param starStr   开始字符串
 @param endStr    结束字符串
 
 @return 截取的字符串
 */
+ (NSString *)subStringByString:(NSString *)string
                 withStarString:(NSString *)starStr
                  withEndString:(NSString *)endStr;

/**
 对数字的处理  个-万-亿
 
 @param number 传入的原始数值
 @param type 1 代表单位个  其他的数值代表 元 可传 2
 @return 返回处理后的数字
 */
+ (NSString *)numberToString:(CGFloat)number
                        type:(NSInteger)type;

/**
 对字符串加中划线
 
 @param string 待处理字符串
 @return 处理后的字符全
 */
+ (NSMutableAttributedString *)attributedTextStrikethroughStyleWithString:(NSString *)string;

/**
 对字符设置文字间距
 
 @param string 待处理字符串
 @return 处理后的字符全
 */
+ (NSMutableAttributedString *)attributedTextJianJuWithString:(NSString *)string;

/**
 *
 label 上添加图片
 @param width 图片的width
 @param image 需要添加的图片
 @param string 需要添加的字符串
 @return 需要显示的富为本
 */
+ (NSMutableAttributedString *)stringWithImageWidthOrHeight:(CGFloat)width
                                                   withImag:(UIImage *)image
                                                 withString:(NSString *)string;

/**
 处理文字中的数字改变颜色
 
 @param text 需要处理的文字
 @return 1
 */
+ (NSMutableAttributedString *)changeNumberColorWithString:(NSString *)text;

/**
 处理文字中的改变颜色
 
 @param string 所有文字
 @param changStr 要改变颜色的文字
 @param color 要改变颜色文字的颜色
 @return 处理后的文字
 */
+ (NSMutableAttributedString *)changeStrColorWithString:(NSString *)string
                                               changStr:(NSString *)changStr
                                                  color:(UIColor *)color;

/**
 为空的字符串返回""
 
 @param string 鉴定字符
 @return string
 */
+ (NSString *)rj_serialize:(NSString *)string;

@end
