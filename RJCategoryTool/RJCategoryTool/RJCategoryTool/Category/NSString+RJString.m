//
//  NSString+RJString.m
//  BMCityCon
//
//  Created by apple on 2018/12/20.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import "NSString+RJString.h"

#import <CommonCrypto/CommonDigest.h>

#import "RJColorAndFont.h"
#import "NSObject+RJCheck.h"

@implementation NSString (RJString)
+ (BOOL)rj_stringIsEmpty:(NSString *)string{
    if ([NSObject rj_objIsEmpty:string]) {
        return YES;
    }
    if (string.length <= 0) {
        return YES;
    }
    return NO;
}


+ (BOOL)isWhitespaceAndNewline:(NSString *)string {
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)hasPrefixIgnoreCase:(NSString *)string {
    return [self hasPrefixIgnoreCase:string
                             options:NSCaseInsensitiveSearch];
}

- (BOOL)hasPrefixIgnoreCase:(NSString *)string
                    options:(NSStringCompareOptions)compareOptions {
    return (![NSString rj_stringIsEmpty:string]) &&
    (self.length >= string.length) &&
    ([self rangeOfString:string options:compareOptions].location == 0);
}

- (BOOL)hasSuffixIgnoreCase:(NSString *)string {
    return [self hasSuffixIgnoreCase:string
                             options:NSCaseInsensitiveSearch];
}

- (BOOL)hasSuffixIgnoreCase:(NSString *)string
                    options:(NSStringCompareOptions)compareOptions {
    return (![NSString rj_stringIsEmpty:string]) &&
    (self.length >= string.length) &&
    ([self rangeOfString:string options:(compareOptions | NSBackwardsSearch)].location == (self.length - string.length));
}

- (BOOL)containsStringIgnoreCase:(NSString *)string {
    return [self containsStringIgnoreCase:string
                                  options:NSCaseInsensitiveSearch];
}

- (BOOL)containsStringIgnoreCase:(NSString *)string
                         options:(NSStringCompareOptions)compareOptions {
    return (![NSString rj_stringIsEmpty:string]) &&
    (self.length >= string.length) &&
    ([self rangeOfString:string options:compareOptions].location != NSNotFound);
}

- (BOOL)isEqualToStringIgnoreCase:(NSString *)string {
    return (![NSString rj_stringIsEmpty:string]) &&
    (self.length == string.length) &&
    ([self rangeOfString:string options:NSCaseInsensitiveSearch].location == 0);
}

- (BOOL)compareVerison:(NSString *)version {
    if ([NSString rj_stringIsEmpty:version]) {
        return YES;
    }
    NSMutableArray *selfArray = [self componentsSeparatedByString:@"."].mutableCopy;
    NSMutableArray *versionArray = [version componentsSeparatedByString:@"."].mutableCopy;
    if (selfArray.count > versionArray.count) {
        [versionArray addObject:@"0"];
    }
    else if (selfArray.count < versionArray.count) {
        [selfArray addObject:@"0"];
    }
    NSInteger smallCount = (selfArray.count > versionArray.count) ? versionArray.count : selfArray.count;
    for (NSInteger i = 0; i < smallCount; i ++) {
        if ([selfArray[i] integerValue] > [versionArray[i] integerValue]) {
            return YES;
        }
        else if ([selfArray[i] integerValue] < [versionArray[i] integerValue]){
            return NO;
        }
    }
    return NO;
}

@end

@implementation NSString (Modify)

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)removeMinus {
    return [[self componentsSeparatedByString:@"-"] componentsJoinedByString:@""];
}

- (NSString *)removeWhiteSpace {
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)removeNewLine {
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)removeWhitespaceAndNewline {
    return [[self removeNewLine] removeWhiteSpace];
}

- (NSString *)addRMBSymbol {
    return [@"￥" stringByAppendingString:self];
}

+ (NSString *)getRandomString:(NSUInteger)lenght {
    NSString *string = @"";
    for (NSUInteger i = 0; i < lenght; i ++) {
        NSInteger number = arc4random() % 36;
        if (number < 10) {
            NSInteger figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%ld", (long)figure];
            string = [string stringByAppendingString:tempString];
        }
        else {
            NSInteger figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

- (NSString *)md5 {
    if ([NSString rj_stringIsEmpty:self]) {
        return nil;
    }
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
}

@end


@implementation NSString (URL)

- (BOOL)URLValidation {
    NSError *error = nil;
    NSString *regulaString =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaString
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self
                                                options:0
                                                  range:NSMakeRange(0, self.length)];
    return arrayOfAllMatches.count > 0 ? YES : NO;
}

- (NSString *)URLStringEncoding {
    CFStringRef encodeRef = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                    (__bridge CFStringRef)self,
                                                                    NULL,
                                                                    CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                    kCFStringEncodingUTF8);
    NSString *urlString = (__bridge NSString *)(encodeRef);
    CFRelease(encodeRef);
    return urlString;
}

- (NSString *)URLStringDecoding {
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                    (__bridge CFStringRef)self,
                                                                                                                    CFSTR(""),
                                                                                                                    CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

- (NSDictionary *)URLParameter {
    //获取问号的位置，问号后是参数列表
    NSRange range = [self rangeOfString:@"?"];
    if (range.length == 0) {
        return nil;
    }
    NSMutableDictionary *resultDictionary = nil;
    NSString *propertys = [self substringFromIndex:(NSInteger)(range.location + 1)];
    NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
    if (subArray.count > 0) {
        resultDictionary = @{}.mutableCopy;
        //把subArray转换为字典
        for(int j = 0; j < subArray.count; j++) {
            //在通过=拆分键和值
            NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
            if (dicArray[1] && dicArray[0]) {
                [resultDictionary setObject:[dicArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                     forKey:[dicArray[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            }
        }
    }
    return resultDictionary;
}

@end

#import <UIKit/UIKit.h>

@implementation NSString (HCCommon)

#pragma mark - NSDecimalNumber
- (NSDecimalNumber *)toTwoPointDecimalNumber {
    return [[NSString stringWithFormat:@"%.2f", self.doubleValue] toDecimalNumber];
}

- (NSDecimalNumber *)toDecimalNumber {
    return [NSDecimalNumber decimalNumberWithString:self];
}

- (CGSize)textSizeIn:(CGSize)size
                font:(UIFont *)font {
    return [self textSizeIn:size
                       font:font
                  breakMode:NSLineBreakByWordWrapping];
}

- (CGSize)textSizeIn:(CGSize)size
                font:(UIFont *)afont
           breakMode:(NSLineBreakMode)breakMode {
    return [self textSizeIn:size
                       font:afont
                  breakMode:NSLineBreakByWordWrapping
                      align:NSTextAlignmentLeft];
}

- (CGSize)textSizeIn:(CGSize)size
                font:(UIFont *)afont
           breakMode:(NSLineBreakMode)abreakMode
               align:(NSTextAlignment)alignment {
    NSLineBreakMode breakMode = abreakMode;
    UIFont *font = afont ? afont : [UIFont systemFontOfSize:14];
    
    CGSize contentSize = CGSizeZero;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = breakMode;
    paragraphStyle.alignment = alignment;
    
    NSDictionary* attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    contentSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    contentSize = CGSizeMake((int)contentSize.width + 1, (int)contentSize.height + 1);
    return contentSize;
}

- (CGSize)sizeWithFont:(UIFont *)font
              maxWidth:(CGFloat)width {
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attrDict
                                     context:nil].size;
    return size;
}

#pragma mark - GRJString
/**
 *  判断是否是手机号
 *  phoneNumber: 手机号
 */
+ (BOOL)isMobilePhoneNumber:(NSString *)phoneNumber{
    if ([NSString rj_stringIsEmpty:phoneNumber]) {
        return NO;
    }
    NSString *MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:phoneNumber];
}

- (BOOL)match:(NSString *)pattern {
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return results.count > 0;
}

- (BOOL)isLoginPassword {
    return [self match:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{4,16}$"];
}

+ (NSString *)phoneNumberDealWithString:(NSString *)string{
    if ([NSString rj_stringIsEmpty:string]) {
        return @"";
    }
    if (string.length < 7) {
        return string;
    }
    NSMutableString *a = [[NSMutableString  alloc] initWithString:string];
    [a replaceCharactersInRange:NSMakeRange(3, string.length-5) withString:@"******"];
    return a.copy;
}

+ (NSString *)userNameDealWithString:(NSString *)string{
    if ([NSString rj_stringIsEmpty:string]) {
        return @"";
    }
    if (string.length == 1) {
        return string;
    }
    NSMutableString *a = [[NSMutableString  alloc] initWithString:string];
    [a replaceCharactersInRange:NSMakeRange(0, string.length - 1)
                     withString:@"*"];
    return a.copy;
}

+ (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    //** 开始进行校验 *//
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else {
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

//计算距离
+ (NSString *)countDistance:(NSNumber *)diatance {
    NSString *diatanceString = @"";
    if (diatance.floatValue > 0 && diatance.floatValue < 1000) {
        diatanceString = [NSString stringWithFormat:@"%@m", [[NSString stringWithFormat:@"%.0f", diatance.floatValue] toTwoPointDecimalNumber]];
    }
    else if(diatance.floatValue >= 1000){
        diatanceString = [NSString stringWithFormat:@"%@km", [[NSString stringWithFormat:@"%.1f", diatance.floatValue/1000] toTwoPointDecimalNumber]];
    }
    else {
        diatanceString = @" ";
    }
    if ([diatanceString isEqualToString:@"0m"]
        || [diatanceString isEqualToString:@"0km"]
        || diatance.floatValue > 200 * 1000) {
        diatanceString = @" ";
    }
    return diatanceString;
}

/**
 截取两个字符串中间的字符串
 
 @param string 要处理的字符串
 @param starStr   开始字符串
 @param endStr    结束字符串
 
 @return 截取的字符串
 */
+ (NSString *)subStringByString:(NSString *)string
                 withStarString:(NSString *)starStr
                  withEndString:(NSString *)endStr {
    NSRange startRange = [string rangeOfString:starStr];
    NSRange endRange = [string rangeOfString:endStr];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [string substringWithRange:range];
}

+ (NSString *)numberToString:(CGFloat)number
                        type:(NSInteger)type{
    if (number < 10000) {
        return [NSString stringWithFormat:@"%.0f%@",number,(type==1)?@"个":@"元"];
    }
    else if (number < 100000000){
        return [NSString stringWithFormat:@"%.1f万",number/10000];
    }
    else {
        return [NSString stringWithFormat:@"%.1f亿",number/100000000];
    }
}

/**
 对字符串加中划线
 
 @param string 待处理字符串
 @return 处理后的字符全
 */
+ (NSMutableAttributedString *)attributedTextStrikethroughStyleWithString:(NSString *)string{
    NSString *oldPrice = string;
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName
                  value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                  range:NSMakeRange(0, length)];
    return attri;
}

//设置文字间距
+ (NSMutableAttributedString *)attributedTextJianJuWithString:(NSString *)string{
    //1 设置行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5.f];
    [paragraphStyle1 setFirstLineHeadIndent:26];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, string.length)];
    return attributedString1;
}

//label 添加图片 RMB_26_orange
+ (NSMutableAttributedString *)stringWithImageWidthOrHeight:(CGFloat)width
                                                   withImag:(UIImage *)image
                                                 withString:(NSString *)string {
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] init];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = image;
    attch.bounds = CGRectMake(0, 0, width, width);
    NSAttributedString *string1 = [NSAttributedString attributedStringWithAttachment:attch];
    NSAttributedString *string2 = [[NSAttributedString alloc]initWithString:string];
    [attri appendAttributedString:string1];
    [attri appendAttributedString:string2];
    return attri;
}

+ (NSMutableAttributedString *)changeStrColorWithString:(NSString *)string
                                               changStr:(NSString *)changStr
                                                  color:(UIColor *)color {
    //1 设置行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:changStr];
    //设置文字颜色
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attributedString1;
}

/**
 处理文字中的数字改变颜色
 
 @param text 需要处理的文字
 @return 1
 */
+ (NSMutableAttributedString *)changeNumberColorWithString:(NSString *)text{
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:text];
    for (int i = 0; i < text.length; i ++) {
        NSString *a = [text substringWithRange:NSMakeRange(i, 1)];
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName: rj_kColor_ff4b00,
                                             NSFontAttributeName: [UIFont systemFontOfSize:12.0]}
                                     range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
}

+ (NSString *)rj_serialize:(NSString *)string {
    return [NSString rj_stringIsEmpty:string] ? @"" : string;
}

@end
