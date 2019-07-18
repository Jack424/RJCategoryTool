//
//  RJBaseTableViewController.h
//  RJCategoryTool
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBaseViewController.h"
#import "RJBaseTableView.h"
#import "RJRefreshHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJBaseTableViewController : RJBaseViewController<UITableViewDataSource, UITableViewDelegate>
/// 数据Array
@property (nonatomic, strong) NSMutableArray *rj_dataArray;

/// tableView
@property (nonatomic, strong) RJBaseTableView *rj_tableView;

/**
 RJEmptyViewType

 @return  默认 RJEmptyViewType_NoData
 RJEmptyViewType_NoData = 0, //暂无内容
 RJEmptyViewType_NoMessage,  //无消息
 RJEmptyViewType_NetworkingError,   //网络问题
 */
- (RJEmptyViewType)rj_emptyViewType;

/**
 emptyViewRetry 点击缺省页响应
 */
- (void)rj_emptyViewRetry;

/**
 rj_tableViewStyle

 @return 默认  UITableViewStyleGrouped
 */
- (UITableViewStyle)rj_tableViewStyle;


/// 刷新表
- (void)rj_reloadData;

- (void)rj_loadNewData;
- (void)rj_loadMoreData;

@property (assign ,nonatomic) BOOL rj_isShowRefreshHeader;
@property (assign ,nonatomic) BOOL rj_isShowRefreshFooter;
@end

NS_ASSUME_NONNULL_END
