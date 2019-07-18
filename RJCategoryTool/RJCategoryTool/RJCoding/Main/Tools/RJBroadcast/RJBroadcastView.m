//
//  RJBroadcastView.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBroadcastView.h"
#import "RJBroadcastModel.h"

@interface RJBroadcastView()

/**
 公告文字轮播视图
 */
@property (nonatomic,strong) UIScrollView *noticeScrollView;
/**
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation RJBroadcastView
-(void)rj_setUIView{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.noticeScrollView];
    [self.noticeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-15);
        make.top.bottom.equalTo(self);
    }];
}
-(UIScrollView *)noticeScrollView{
    if (!_noticeScrollView) {
        _noticeScrollView = [[UIScrollView alloc] init];
        _noticeScrollView.showsHorizontalScrollIndicator = NO;
        _noticeScrollView.showsVerticalScrollIndicator = NO;
        _noticeScrollView.scrollEnabled = NO;
        _noticeScrollView.pagingEnabled = NO;
    }
    return _noticeScrollView;
}
-(void)setScrollViewLabel{
    [self.noticeScrollView grj_removeAllSubviews];
    for (int i = 0; i < self.titleArray.count; i++) {
        UILabel *titleLabel = [RJInitViewTool rj_initLabelWithSuperView:self.noticeScrollView
                                                                   text:self.titleArray[i]
                                                                   font:[UIFont systemFontOfSize:13]
                                                              textColor:rj_kColor_999999];
        
        titleLabel.tag = i;
        titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheLabel:)];
        [titleLabel addGestureRecognizer:tap];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(self.noticeScrollView);
            make.height.mas_equalTo(self.cellHight);
            make.top.equalTo(self.noticeScrollView).offset(i * self.cellHight);
            if (i==self.titleArray.count-1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.noticeScrollView.contentSize = CGSizeMake(0, self.cellHight * self.titleArray.count);
                });
            }
        }];
    }
}
- (void)clickTheLabel:(UITapGestureRecognizer *)tap {
    RJBroadcastModel *model = _modelArray[tap.view.tag];
}

- (void)setModelArray:(NSArray *)modelArray {
    _modelArray = modelArray;
    NSMutableArray *textArray = [NSMutableArray arrayWithCapacity:0];
    for (RJBroadcastModel *model in modelArray) {
        [textArray addObject:model.content];
    }
    self.titleArray = textArray;
}

-(void)setTitleArray:(NSArray *)titleArray{
    if (!(self.cellHight>0)) {
        self.cellHight = 38;
    }
    /*全局一次布局
     if (!(_titleArray.count>0)) {
     _titleArray = titleArray;
     [self setScrollViewLabel];
     if (_titleArray.count>0) {
     [self addTimer];
     }
     }
     */
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _titleArray = titleArray;
    [self setScrollViewLabel];
    if (_titleArray.count>0) {
        [self addTimer];
    }
}
- (void)nextLabel {
    CGPoint oldPoint = self.noticeScrollView.contentOffset;
    oldPoint.y += self.cellHight;
    CGFloat xishu = oldPoint.y >(self.titleArray.count-1) * self.cellHight ? 0 : oldPoint.y;
    [self.noticeScrollView setContentOffset:CGPointMake(0 ,xishu) animated:xishu];
    
}
- (void)addTimer{
    self.timer = [NSTimer timerWithTimeInterval:2.5 target:self selector:@selector(nextLabel) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}


@end
