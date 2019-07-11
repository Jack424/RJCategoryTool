//
//  RJEmptyView.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJEmptyView.h"

@implementation RJEmptyView

- (void)prepare{
    [super prepare];
    self.contentViewOffset = - 88.0;
    self.subViewMargin = 16.0;
    self.titleLabFont = [UIFont systemFontOfSize:14.0];
    self.titleLabTextColor = rj_kColor_999999;
}

+ (instancetype)emptyViewWithType:(RJEmptyViewType)type
                         tapBlock:(LYActionTapBlock)tapBlock{
    NSString *imageName = nil;
    NSString *title = nil;
    switch (type) {
        case RJEmptyViewType_NoData: {
            imageName = @"NoContent";
            title = @"暂无内容";
        }
            break;
        case RJEmptyViewType_NoMessage: {
            imageName = @"NoMessage";
            title = @"暂时还没有消息";
        }
            break;
        case RJEmptyViewType_NetworkingError: {
            imageName = @"NetworkingError";
            title = @"网络不给力";
        }
            break;
            
        default:
            break;
    }
    if ([NSString rj_stringIsEmpty:imageName] ||
        [NSString rj_stringIsEmpty:title]) {
        return nil;
    }
    RJEmptyView *emptyView;
    if (type == RJEmptyViewType_NetworkingError) {
        emptyView = [RJEmptyView  emptyActionViewWithImageStr:imageName titleStr:title detailStr:nil btnTitleStr:@"去逛逛" btnClickBlock:^{
                                                    NSLog(@"点了缺省页的按钮,你想做什么");
                                                    NSLog(@"点了缺省页的按钮,你想做什么");
                                                    NSLog(@"点了缺省页的按钮,你想做什么");
                                                    
                                                    NSLog(@"点了缺省页的按钮,你想做什么");
                                                    NSLog(@"点了缺省页的按钮,你想做什么");
                                                    NSLog(@"点了缺省页的按钮,你想做什么");
                                                }];
        emptyView.actionBtnFont = [UIFont systemFontOfSize:15.f];
        emptyView.actionBtnTitleColor = [UIColor whiteColor];
        emptyView.actionBtnHeight = 40.f;
        emptyView.actionBtnCornerRadius = 20.f;
        emptyView.actionBtnBackGroundColor = rj_kColor_ff4b00;
    } else {
        emptyView = [RJEmptyView emptyViewWithImageStr:imageName
                                              titleStr:title
                                             detailStr:nil];
    }
    //[emptyView setTapContentViewBlock:tapBlock];
    [emptyView setTapEmptyViewBlock:tapBlock];
    return emptyView;
}
@end
