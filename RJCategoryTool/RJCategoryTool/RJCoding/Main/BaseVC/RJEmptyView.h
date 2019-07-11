//
//  RJEmptyView.h
//  RJCategoryTool
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "LYEmptyView.h"

typedef NS_ENUM(NSUInteger, RJEmptyViewType) {
    RJEmptyViewType_NoData = 0, //暂无内容
    RJEmptyViewType_NoMessage,  //无消息
    
    RJEmptyViewType_NetworkingError,   //网络问题
};

NS_ASSUME_NONNULL_BEGIN

@interface RJEmptyView : LYEmptyView
/**
 缺省页面
 
 @param type type
 @return HBEmptyView
 */
+ (instancetype)emptyViewWithType:(RJEmptyViewType)type
                         tapBlock:(LYActionTapBlock)tapBlock;
@end

NS_ASSUME_NONNULL_END
