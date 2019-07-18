//
//  RJBaseListTableViewController.h
//  RJCategoryTool
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJBaseListTableViewController : RJBaseViewController<UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate>
@property(nonatomic,strong)NSArray *dataSource;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIImageView *backImageView;

@end

NS_ASSUME_NONNULL_END
