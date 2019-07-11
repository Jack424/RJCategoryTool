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
@end

NS_ASSUME_NONNULL_END
