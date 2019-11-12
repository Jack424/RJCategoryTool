//
//  RJGTool.m
//  RJCategoryTool
//
//  Created by JinTian on 2019/11/12.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJGTool.h"

@implementation RJGTool

/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  字数限制   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/
/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  字数限制   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/
/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  字数限制   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/

+(BOOL)rjg_textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text limitCount:(NSInteger)limitCount  :(UILabel *)countLabel{
    //1 文字高亮部分的处理
    UITextRange *selectedRange= [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos       = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset   = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange   = NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location < limitCount) return YES;
        else return NO;
    }
    //2 输入文字后的处理
    NSString *comcatStr       = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen     = limitCount-comcatStr.length;
    if (caninputlen>=0) return YES;
    else{
        NSInteger len = text.length+caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len, 0)};
        if (rg.length>0) {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }else{
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                    if (idx >= rg.length) {
                        *stop = YES; //取出所需要就break，提高效率
                        return ;
                    }
                    trimString = [trimString stringByAppendingString:substring];
                    idx++;
                }];
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            NSLog(@"---%@",[NSString stringWithFormat:@"grj----%d/%ld",0,(long)limitCount]);
            countLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)limitCount];
        }
        return NO;
    }
}
//返回  -1时外界不做审核处理
+(NSInteger)rjg_textViewDidChange:(UITextView *)textView limitCount:(NSInteger)limitCount :(UILabel *)countLabel{
    //1 文字高亮部分的处理
    UITextRange    *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos           = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) return -1;
    //2 输入文字后的处理
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum   = nsTextContent.length;
    
    if (existTextNum > limitCount){
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:limitCount];
        [textView setText:s];
    }
    //不让显示负数
    NSLog(@"---%@",[NSString stringWithFormat:@"%ld/%ld",MAX(0,limitCount - existTextNum),(long)limitCount]);
    countLabel.text = [NSString stringWithFormat:@"%ld/%ld",MAX(0,limitCount - existTextNum),(long)limitCount];
    return MAX(0,limitCount - existTextNum);
}
/*************************   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  字数限制   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑   *****************************/
/*************************   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  字数限制   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑   *****************************/
/*************************   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  字数限制   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑   *****************************/



/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  关键字改变颜色字体   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/
/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  关键字改变颜色字体   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/
/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  关键字改变颜色字体   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/
#pragma mark -- 设置在一个文本中所有特殊字符的特殊颜色 模糊匹配
+ (NSMutableAttributedString *)rjg_setAllText:(NSString *)allStr andSpcifiStr:(NSString *)keyWords withColor:(UIColor *)color specifiStrFont:(UIFont *)font{
    NSMutableAttributedString *mutableAttributedStr = [[NSMutableAttributedString alloc] initWithString:allStr];
    if (color == nil) {
        color = [UIColor redColor];
    }
    if (font == nil) {
        font = [UIFont systemFontOfSize:17];
    }
    for (NSInteger j=0; j<=keyWords.length-1; j++) {
        
        NSRange searchRange = NSMakeRange(0, [allStr length]);
        NSRange range;
        NSString *singleStr = [keyWords substringWithRange:NSMakeRange(j, 1)];
        while
            ((range = [allStr rangeOfString:singleStr options:NSLiteralSearch range:searchRange]).location != NSNotFound) {
                //改变多次搜索时searchRange的位置
                searchRange = NSMakeRange(NSMaxRange(range), [allStr length] - NSMaxRange(range));
                //设置富文本
                [mutableAttributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
                [mutableAttributedStr addAttribute:NSFontAttributeName value:font range:range];
            }
    }
    return mutableAttributedStr;
}
+ (NSAttributedString *)rjg_colorAttributeString:(NSString *)sourceString sourceSringColor:(UIColor *)sourceColor sourceFont:(UIFont *)sourceFont keyWordArray:(NSArray<NSString *> *)keyWordArray keyWordColor:(UIColor *)keyWordColor keyWordFont:(UIFont *)keyWordFont{
    if (sourceString == nil || ![sourceString isKindOfClass:[NSString class]]) {
        sourceString = @"";
    }
    NSMutableArray *muKeyWordsArr;
    if (keyWordArray == nil) {
        muKeyWordsArr = [NSMutableArray arrayWithCapacity:0];
    }else{
        muKeyWordsArr = keyWordArray.mutableCopy;
    }
    if (sourceColor == nil) {
        sourceColor = [UIColor blackColor];
    }
    if (keyWordColor == nil) {
        keyWordColor = [UIColor blackColor];
    }
    if (sourceFont == nil) {
        sourceFont = [UIFont systemFontOfSize:15];
    }
    if (keyWordFont == nil) {
        keyWordFont = [UIFont systemFontOfSize:15];
    }
    NSMutableAttributedString *attributeContent;
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [ps setLineBreakMode:NSLineBreakByTruncatingTail];
    NSDictionary *attriDic = @{NSFontAttributeName : sourceFont,NSForegroundColorAttributeName : sourceColor,NSParagraphStyleAttributeName : ps};
    attributeContent = [[NSMutableAttributedString alloc] initWithString:sourceString attributes:attriDic];
    [muKeyWordsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *searchKey = (NSString *)obj;
        NSError *error = nil;
        NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:searchKey options:NSRegularExpressionCaseInsensitive error:&error];
        if (!expression) {
        }else{
            [expression enumerateMatchesInString:sourceString options:NSMatchingReportProgress range:NSMakeRange(0, sourceString.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                [attributeContent addAttributes:@{NSFontAttributeName : keyWordFont,NSForegroundColorAttributeName:keyWordColor} range:result.range];
            } ];
        }
    }];
    return attributeContent;
}
/*************************   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  关键字改变颜色字体   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑   *****************************/
/*************************   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  关键字改变颜色字体   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑   *****************************/
/*************************   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  关键字改变颜色字体   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑   *****************************/


+(void)rjg_logAllPropertyFromClass:(NSString *)className{
    unsigned int count;
    // 获取class里所有的成员属性
    Ivar *ivars = class_copyIvarList(NSClassFromString(className), &count);
    for (int i = 0; i < count; i++) {
        // 获取成员属性
        Ivar ivar = ivars[i];
        // 获取成员属性的属性名
        NSString *name = @(ivar_getName(ivar));
        NSLog(@"%@",name);
    }
    free(ivars);
}
+ (void)rjg_logAllMethodFromClass:(NSString *)className{
    unsigned int  count;
    //class_copyMethodList 获取类的所有方法列表
    Method *methods = class_copyMethodList(NSClassFromString(className),&count) ;
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        // method_getImplementation  由Method得到IMP函数指针
        //IMP imp_f = method_getImplementation(temp_f);
        
        // 由Method得到SEL
        SEL method_sel = method_getName(method);
        // 由SEL得到方法名
        const char *name = sel_getName(method_sel);
        // 由Method得到参数个数
        int arguments = method_getNumberOfArguments(method);
        // 由Method得到Encoding 类型  获取方法的Type字符串(包含参数类型和返回值类型)
        const char * encoding = method_getTypeEncoding(method);
        
        NSLog(
              @"\n 方法名：%@\n 参数个数：%d\n 编码方式：%@",
              [NSString stringWithUTF8String:name],
              arguments,
              [NSString stringWithUTF8String:encoding]
              );
    }
    free(methods);
    
}



//放大效果，并回到原位
+(CABasicAnimation *)rjg_transformScale{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.3];     //结束伸缩倍数
    return animation;
}
//Z轴旋转
+(CABasicAnimation *)rjg_transformRotationZ{
    //z轴旋转180度
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:M_PI];     //结束伸缩倍数
    return animation;
}
//Y轴位移
+(CABasicAnimation *)rjg_transformTranslationY{
    //向上移动
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:-10];     //结束伸缩倍数
    return animation;
}
//放大并保持
+(CABasicAnimation *)rjg_transformScaleState{
    //放大效果
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;           //保证动画效果延续
    animation.fromValue = [NSNumber numberWithFloat:1.0];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.15];     //结束伸缩倍数
    return animation;
}

+(CABasicAnimation *)rjg_randomTransform{
    NSArray *selArray = @[@"rjg_transformScale",@"rjg_transformRotationZ",@"rjg_transformTranslationY",@"rjg_transformScaleState"];
    SEL selector = NSSelectorFromString(selArray[arc4random()%selArray.count]);
    return ((CABasicAnimation* (*)(id,SEL))objc_msgSend)([RJCoreTool class],selector);
};

+(NSAttributedString *)rjg_changeLabelLineSpace:(NSString *)string withLineSpace:(CGFloat)lineSpace withFirstLineHeadIndent:(CGFloat)firstLine{
    if ([NSString rj_stringIsEmpty:string]) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    if (lineSpace) {
        [paragraphStyle1 setLineSpacing:lineSpace];
    }
    if (firstLine) {
        [paragraphStyle1 setFirstLineHeadIndent:firstLine];
    }
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, string.length)];
    return attributedString1;
}
@end
