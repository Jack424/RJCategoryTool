//
//  RJBaseModalViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/18.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBaseModalViewController.h"
#define ANIMATEDURATION 0.3

@interface RJBaseModalViewController ()
@property(nonatomic,strong)UIView *backView;
@end

@implementation RJBaseModalViewController

-(instancetype)init{
    if (self = [super init]) {
        self.backViewColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self settingModal];
        [self.view insertSubview:self.backView atIndex:0];
    }
    return self;
}
-(void)dealloc{
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.backViewColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [UIView animateWithDuration:ANIMATEDURATION animations:^{
        [self rj_appearAnimate];
    } completion:^(BOOL finished) {
        if (_appearAnimateCompletion) {
            _appearAnimateCompletion();
        }
    }];
}
// 设置透明modal背景变黑的解决办法
-(void)settingModal{
    self.view.backgroundColor = [UIColor clearColor];
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
}
-(void)setBackViewColor:(UIColor *)backViewColor{
    _backViewColor = backViewColor;
    self.backView.backgroundColor = backViewColor;
}
-(UIView *)backView{
    if (!_backView) {
        UIView *backView = [[UIView alloc]initWithFrame:self.view.bounds];
        backView.backgroundColor = self.backViewColor;
        backView.alpha = 0;
        if (!_isCancelBackDismiss) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissThisViewC)];
            [backView addGestureRecognizer:tap];
        }
        _backView = backView;
    }
    return _backView;
}
-(void)dismissThisViewC:(void (^)(void))completion{
    [self.view endEditing:YES];
    [UIView animateWithDuration:ANIMATEDURATION animations:^{
        [self rj_disappearAnimate];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (completion) {
                completion();
            }
        }];
    }];
}
-(void)dismissThisViewC{
    [UIView animateWithDuration:ANIMATEDURATION animations:^{
        [self rj_disappearAnimate];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (_dismissComplete) {
                _dismissComplete();
            }
        }];
    }];
}
-(void)rj_disappearAnimate{
    self.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
}
-(void)rj_appearAnimate{
    self.backView.alpha = 1.0;
}

@end
