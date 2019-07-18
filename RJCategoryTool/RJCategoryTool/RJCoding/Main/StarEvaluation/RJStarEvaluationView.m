//
//  RJStarEvaluationView.m
//  BMCityCon
//
//  Created by apple on 2019/4/19.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJStarEvaluationView.h"
typedef void(^EvaluateViewDidChooseStarBlock)(NSUInteger count);

@interface RJStarEvaluationView ()

@property (nonatomic, assign)   NSUInteger index;
@property (nonatomic, copy)     EvaluateViewDidChooseStarBlock evaluateViewChooseStarBlock;

@end
@implementation RJStarEvaluationView


/**************初始化TggEvaluationView*************/
+ (instancetype)evaluationViewWithChooseStarBlock:(void(^)(NSUInteger count))evaluateViewChoosedStarBlock {
    RJStarEvaluationView *evaluationView = [[RJStarEvaluationView alloc] init];
    evaluationView.backgroundColor = [UIColor clearColor];
    evaluationView.evaluateViewChooseStarBlock = ^(NSUInteger count) {
        if (evaluateViewChoosedStarBlock) {
            evaluateViewChoosedStarBlock(count);
        }
    };
    return evaluationView;
}

#pragma mark - AccessorMethod
- (void)setStarCount:(NSUInteger)starCount {
    if (starCount == 0) {
        return;
    }
    //NSLog(@"%lu---%lu",(unsigned long)_starCount,starCount);
    if (_starCount != starCount) {
        _starCount = starCount;
        if (starCount > 5) {
            starCount = 5;
        }
        self.index = starCount;
        [self setNeedsDisplay];
        if (self.evaluateViewChooseStarBlock) {
            self.evaluateViewChooseStarBlock(self.index);
        }
    }
}
/*
 if (_starCount != starCount) {
 _starCount = starCount;
 if (starCount > 5) {
 starCount = 5;
 }
 self.index = starCount;
 [self setNeedsDisplay];
 if (self.evaluateViewChooseStarBlock) {
 self.evaluateViewChooseStarBlock(self.index);
 }
 }
 */

- (void)setTapEnabled:(BOOL)tapEnabled {
    _tapEnabled = tapEnabled;
    self.userInteractionEnabled = tapEnabled;
}

- (void)setSpacing:(CGFloat)spacing {
    if (_spacing != spacing) {
        _spacing = spacing;
        [self setNeedsDisplay];
    }
}
#pragma mark - DrawStarsMethod

/**************重写*************/
- (void)drawRect:(CGRect)rect {
    UIImage *norImage = self.isEmptyStarHidden?nil:[UIImage imageNamed:@"bm_chat_nocollect"];
    UIImage *selImage = [UIImage imageNamed:@"bm_chat_collect"];
    // 图片没间隙自己画
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 默认间隙为星星一半
    CGFloat spacing = self.frame.size.width / 20;
    CGFloat top = 0;
    CGFloat starWidth = spacing * 2;
    if (self.spacing != 0) {
        if (self.spacing > 1) {
            self.spacing = 1;
        }
        starWidth = self.frame.size.width / (self.spacing * 10 + 5);
        spacing = starWidth * self.spacing;
    }
    // 如果高度过高则居中
    if (self.frame.size.height > starWidth) {
        top = (self.frame.size.height - starWidth) / 2;
    }
    // 画图
    for (NSInteger i = 0; i < 5; i ++) {
        UIImage *drawImage = i < self.index ? selImage : norImage;
        [self drawImage:context CGImageRef:drawImage.CGImage CGRect:CGRectMake((i == 0) ? spacing : 2 * i * spacing + spacing + starWidth * i, top, starWidth, starWidth)];
    }
    // 瞬间画满,需要图片有间隙
    //CGContextDrawTiledImage(context, CGRectMake(0, 0, 30, 30), image.CGImage);
}

/**************将坐标翻转画图*************/
- (void)drawImage:(CGContextRef)context
       CGImageRef:(CGImageRef)image
           CGRect:(CGRect)rect {
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    CGContextDrawImage(context, rect, image);
    
    CGContextRestoreGState(context);
}


#pragma mark - TouchGestureMethod

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.x<0) {
        self.index =  1;
    }else{
        self.index = point.x / (self.frame.size.width / 5) + 1;
    }
    
    if (self.index >= 6) {
        self.index = 5;
    }
    [self setNeedsDisplay];
    if (self.evaluateViewChooseStarBlock) {
        self.evaluateViewChooseStarBlock(self.index);
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}


@end