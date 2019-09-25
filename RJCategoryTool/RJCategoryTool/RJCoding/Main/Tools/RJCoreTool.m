//
//  RJCoreTool.m
//  RJPrecious
//
//  Created by 易上云 on 2017/10/25.
//  Copyright © 2017年 GRJ. All rights reserved.
//

#import "RJCoreTool.h"
@interface RJCoreTool()

@end

@implementation RJCoreTool
//矩形
+(UIBezierPath *)rj_bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius{
    return [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
}
//直线
+(UIBezierPath *)rj_bezierPathMoveAndAddLineToPoint{
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(100, 50)];
    [path2 addLineToPoint:CGPointMake(250, 50)];
    [path2 addLineToPoint:CGPointMake(250, 200)];
    [path2 addLineToPoint:CGPointMake(100, 200)];
    [path2 addLineToPoint:CGPointMake(100, 50)];
    [path2 addQuadCurveToPoint:CGPointMake(250, 200) controlPoint:CGPointMake(200, 50)];
    [path2 addQuadCurveToPoint:CGPointMake(100, 50) controlPoint:CGPointMake(50, 200)];
    return path2;
}
//椭圆     前两个参数分别代码圆的圆心,后面两个参数分别代表圆的宽度,与高度.
+(UIBezierPath *)rj_bezierPathWithOvalInRect:(CGRect)rect{
    return [UIBezierPath bezierPathWithOvalInRect:rect];
}

//圆弧
+(UIBezierPath *)rj_bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise{
    //Center:当前的弧所在圆的圆心//radius:圆半径//startAngle:开始角度//endAngle:截至角度//clockwise:方向.
    CGPoint center1 = center;
    CGFloat radius1 = radius;
    CGFloat startA  = startAngle;//圆的0度角在圆的最右侧,
    CGFloat endA    = endAngle;
    return  [UIBezierPath bezierPathWithArcCenter:center1 radius:radius1 startAngle:startA endAngle:endA clockwise:clockwise];
}
+(UIView *)rj_setUpSubViewsWithController:(UIViewController *)controller :(NSArray *)buttonTitleArray action:(SEL)action{
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor clearColor];
    [controller.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(controller.view);
        make.height.mas_equalTo(280);
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor clearColor];
    [controller.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(controller.view);
        make.top.equalTo(topView.mas_bottom);
    }];
    
    CGFloat count = buttonTitleArray.count;
    for (int i =0; i<count; i++) {
        int column = 3;
        int row = i / column;
        int col = i % column;
        CGFloat buttonSpace = 15;
        CGFloat width = (rj_kScreenWidth-column * 2 * buttonSpace)/column;
        CGFloat height = 25;
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = i;
        button.layer.cornerRadius = 3;
        button.layer.borderColor = rj_kColor_ff4b00.CGColor;
        button.layer.borderWidth = 1;
        [button setTitleColor:rj_kColor_ff4b00 forState:UIControlStateNormal];
        button.titleLabel.font = rj_kFont_24;
        [button setTitle:[buttonTitleArray[i] firstObject] forState:UIControlStateNormal];
        [button addTarget:controller action:action forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake(col * (width + 2 * buttonSpace) +buttonSpace, row * (height + buttonSpace) +buttonSpace, width, height);
        
        [topView addSubview:button];
    }
    
    return bottomView;
    
}


/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  字数限制   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/
/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  字数限制   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/
/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  字数限制   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/

+(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text limitCount:(NSInteger)limitCount{
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
        }
        return NO;
    }
}
//返回  -1时外界不做审核处理
+(NSInteger)textViewDidChange:(UITextView *)textView limitCount:(NSInteger)limitCount{
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
    return MAX(0,limitCount - existTextNum);
}
/*************************   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  字数限制   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑   *****************************/
/*************************   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  字数限制   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑   *****************************/
/*************************   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  字数限制   ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑   *****************************/


+(void)rj_logAllPropertyFromClass:(NSString *)className{
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
+ (void)rj_logAllMethodFromClass:(NSString *)className{
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
+(CABasicAnimation *)rj_transformScale{
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
+(CABasicAnimation *)rj_transformRotationZ{
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
+(CABasicAnimation *)rj_transformTranslationY{
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
+(CABasicAnimation *)rj_transformScaleState{
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

+(CABasicAnimation *)rj_randomTransform{
    NSArray *selArray = @[@"rj_transformScale",@"rj_transformRotationZ",@"rj_transformTranslationY",@"rj_transformScaleState"];
    SEL selector = NSSelectorFromString(selArray[arc4random()%selArray.count]);
    return ((CABasicAnimation* (*)(id,SEL))objc_msgSend)([RJCoreTool class],selector);
};
+(CGFloat)calculatorHeightWithString:(NSString *)string Font:(UIFont *)font Add:(CGFloat)addNum{
    if (!string) {
        string = @"";
    }
    return [string boundingRectWithSize:CGSizeMake(rj_kScreenWidth-rj_kValue_60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height + addNum;
}
+(CGFloat)calculatorAuctionMineHeightWithString:(NSString *)string Font:(UIFont *)font Add:(CGFloat)addNum{
    if ([NSString rj_stringIsEmpty:string]) {
        string = @"";
    }
    return [string boundingRectWithSize:CGSizeMake(rj_kScreenWidth-rj_kValue_60-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height + addNum;
}



// 比较两个时间的大小
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
}
+(NSString *)maxExpireTime:(NSDate *)date withYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day{
    NSDate * mydate = date;
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:year];
    
    [adcomps setMonth:month];
    
    [adcomps setDay:day];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    
    return beforDate;
    
    NSLog(@"%@", beforDate);
}


+(NSAttributedString *)changeTextColor:(NSString *)text withChangeTextArray:(NSArray *)stringArray withFont:(UIFont *)font withColor:(UIColor *)color{
    if ((!color && !font) || [NSString rj_stringIsEmpty:text]) {//判空
        return [[NSAttributedString alloc] initWithString:@""];
    }
    if (!stringArray || !stringArray.count) {
        stringArray = @[@"0", @"1", @"2", @"3", @"4", @"5",@"6", @"7", @"8", @"9"];
    }
    //    NSString *text = string;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    //设置要改变的属性
    NSMutableDictionary *attributesDict = [NSMutableDictionary dictionaryWithCapacity:0];
    if (font) {
        [attributesDict setObject:font forKey:NSFontAttributeName];
    }
    if (color) {
        [attributesDict setObject:color forKey:NSForegroundColorAttributeName];
    }
    
    //中间删除线
    //    [attributesDict setObject:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
    //    [attributesDict setObject:kHCColor_999999 forKey:NSStrikethroughColorAttributeName];
    //    //iOS 10.3之后富文本的NSUnderlineStyleSingle系统都能正常显示，更新最新之后没不见了 加下面一句话
    //    [attributesDict setObject:@(0) forKey:NSBaselineOffsetAttributeName];
    
    //关键字高亮处理
    [[RJCoreTool expressionWithPattern:[RJCoreTool regularPattern:stringArray]] enumerateMatchesInString:text  options:0 range:NSMakeRange(0, [text length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange matchRange = [result range];
        if (attributesDict) {
            [attributedString addAttributes:attributesDict range:matchRange];
        }
        
        if ([result resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [result URL];
            [attributedString addAttribute:NSLinkAttributeName value:url range:matchRange];
        }
    }];
    
    return attributedString;
}
/**
 用了OC自带的 NSRegularExpression 来进行正则表达式匹配
 
 @param pattern 关键字集合字符串
 @return NSRegularExpression
 */
+(NSRegularExpression *)expressionWithPattern:(NSString *)pattern {
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    return expression;
}
/**
 正则判断
 
 @param keys 关键字数组
 @return 关键字的字符串集合字符串
 */
+(NSString *)regularPattern:(NSArray *)keys{
    if (keys.count==0) {
        return @"";
    }
    NSMutableString *pattern = [[NSMutableString alloc]initWithString:@"(?i)"];
    
    for (NSString *key in keys) {
        [pattern appendFormat:@"%@|",key];
    }
    
    return pattern;
}
+(NSAttributedString *)changeLabelLineSpace:(NSString *)string withLineSpace:(CGFloat)lineSpace withFirstLineHeadIndent:(CGFloat)firstLine{
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
+(NSMutableAttributedString *)changeTextColor:(NSString *)text withChangeText:(NSString *)changeText withFont:(UIFont*)font withColor:(UIColor *)color {
    if ([NSString rj_stringIsEmpty:changeText] || [NSString rj_stringIsEmpty:text]) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    //设置要改变的属性
    NSMutableDictionary *attributesDict = [NSMutableDictionary dictionaryWithCapacity:0];
    if (font) {
        [attributesDict setObject:font forKey:NSFontAttributeName];
    }
    if (color) {
        [attributesDict setObject:color forKey:NSForegroundColorAttributeName];
    }
    NSRange range = [text rangeOfString:changeText];
    [attributedString addAttributes:attributesDict range:range];
    
    return attributedString;
};

@end
