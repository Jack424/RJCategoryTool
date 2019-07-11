//
//  RJRefreshHeader.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJRefreshHeader.h"
@implementation RJRefreshHeader
-(void)prepare{
    [super prepare];
    //自动改变透明度 （当控件被导航条挡住后不显示）
    self.automaticallyChangeAlpha = YES;
    
    // 设置各种状态下的刷新文字
    [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    
    
    
    // 设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:13];
    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置颜色
    self.stateLabel.textColor = [UIColor grayColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    //初始化时开始刷新
    [self beginRefreshing];
}
//- (instancetype)init {
//    
//    self = [super init];
//    if (self) {
//        
//        
//        
//    }
//    return self;
//}
@end


@implementation RJRefreshFooter
-(void)prepare{
    [super prepare];
    //自动改变透明度 （当控件被导航条挡住后不显示）
    self.automaticallyChangeAlpha = YES;
    
    // 设置各种状态下的刷新文字
    
    [self setTitle:@"上拉可以刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"已经到底了" forState:MJRefreshStateNoMoreData];
    
    
    // 设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置颜色
    self.stateLabel.textColor = [UIColor grayColor];
    
    //初始化时开始刷新
    //[self beginRefreshing];
    
}
//- (instancetype)init {
//
//    self = [super init];
//    if (self) {
//
//
//
//    }
//    return self;
//}
@end

