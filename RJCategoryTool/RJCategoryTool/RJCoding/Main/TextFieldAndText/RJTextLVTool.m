//
//  RJTextLVTool.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/18.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJTextLVTool.h"

@implementation RJTextLVTool
//设置文字间距
+(NSMutableAttributedString *)rj_mutableAttributedPlaceStringWithString:(NSString *)string{
    //1 设置行间距
    //实例化NSMutableAttributedString模型
    if ([NSString rj_stringIsEmpty:string]) {
        string = @"";
    }
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:string];
    //建立行间距模型
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    //设置行间距
    [paragraphStyle1 setLineSpacing:5.f];
    //[paragraphStyle1 setFirstLineHeadIndent:24];
    //把行间距模型加入NSMutableAttributedString模型
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, string.length)];
    //    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0, string.length)];
    //    //设置文字颜色
    //    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, string.length)];
    return attributedString1;
}
+(CGFloat)rj_calculatorHeightWithString:(NSString *)string Font:(UIFont *)font Add:(CGFloat)addNum{
    if ([NSString rj_stringIsEmpty:string]) {
        string = @"";
    }
    return [string boundingRectWithSize:CGSizeMake(rj_kScreenWidth-rj_kValue_60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height + addNum;
}


//设置全局的UIBarButtonItem
+ (UIBarButtonItem *)rj_itemWithBarButtonItem:(UIBarButtonItem *)barButtonItem{
    //设置导航条右边文字
    [barButtonItem setTintColor:rj_kColor_ff4b00];
    [barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    return  barButtonItem;
}


/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  字数限制   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/
/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  字数限制   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/
/*************************   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  字数限制   ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓   *****************************/

+(BOOL)rj_textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text limitCount:(NSInteger)limitCount  :(UILabel *)countLabel{
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
+(NSInteger)rj_textViewDidChange:(UITextView *)textView limitCount:(NSInteger)limitCount :(UILabel *)countLabel{
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


+(NSString *)rj_jobTimeWithbeginTime:(NSString * _Nonnull)beginTime endTime:(NSString * _Nonnull)endTime serviceDate:(NSString * _Nonnull)serviceDate{
    NSArray *dateArray = [serviceDate componentsSeparatedByString:@","];
    NSString *weekStr = @"";
    if (dateArray.count==7) {
        weekStr = @"每天";
    }else{
        weekStr = [dateArray componentsJoinedByString:@","];
        weekStr = [NSString stringWithFormat:@"星期%@",weekStr];
    }
    return  [NSString stringWithFormat:@"%@-%@ %@",[NSDate dateStyleSixTimeIntervalToDateString:beginTime],[NSDate dateStyleSixTimeIntervalToDateString:endTime],weekStr];
}

@end
