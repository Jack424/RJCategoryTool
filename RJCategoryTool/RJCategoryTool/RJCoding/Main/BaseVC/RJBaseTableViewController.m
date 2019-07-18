//
//  RJBaseTableViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBaseTableViewController.h"
#import "UIView+Empty.h"

@interface RJBaseTableViewController ()
@property (nonatomic, strong) RJRefreshHeader *refreshHeader;
@property (nonatomic, strong) RJRefreshFooter *refreshFooter;
@end

@implementation RJBaseTableViewController

- (void)rj_setUpSubviews {
    [super rj_setUpSubviews];
    [self.view addSubview:self.rj_tableView];
    [self.rj_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self rj_loadNewData];
    [self.rj_tableView ly_startLoading];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rj_dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifierWithIndexPath:indexPath] forIndexPath:indexPath];
//    [self configureCell:cell atIndexPath:indexPath];
    
    UITableViewCell *cell =  [[UITableViewCell alloc]init];
    cell.textLabel.text = @"MyName";
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath {
    //cell.fd_enforceFrameLayout = NO;
}

- (NSString *)cellIdentifierWithIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return [tableView fd_heightForCellWithIdentifier:[self cellIdentifierWithIndexPath:indexPath]
//                                    cacheByIndexPath:indexPath
//                                       configuration:^(UITableViewCell *cell) {
//                                           [self configureCell:cell
//                                                   atIndexPath:indexPath];
//                                       }];
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Getter
-(NSMutableArray *)rj_dataArray{
    if (!_rj_dataArray) {
        _rj_dataArray = [NSMutableArray array];
    }
    return _rj_dataArray;
}
-(RJBaseTableView *)rj_tableView{
    if (!_rj_tableView) {
        _rj_tableView = [[RJBaseTableView alloc]initWithFrame:CGRectZero style:[self rj_tableViewStyle]];
        _rj_tableView.backgroundColor = [UIColor clearColor];
        _rj_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rj_tableView.estimatedRowHeight = 0;
        _rj_tableView.estimatedSectionFooterHeight = 0;
        _rj_tableView.estimatedSectionHeaderHeight = 0;
        //weakify(self)
        rj_weakify(self)
        _rj_tableView.ly_emptyView = [RJEmptyView emptyViewWithType:[self rj_emptyViewType]
                                                        tapBlock:^{
                                                            //strongify(self)
                                                            [RJWeak_self rj_emptyViewRetry];
                                                        }];
        _rj_tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _rj_tableView.ly_emptyView.autoShowEmptyView = NO;
        _rj_tableView.delegate = self;
        _rj_tableView.dataSource = self;
        if(@available(iOS 11.0,*)) {
            _rj_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        if (self.rj_isShowRefreshHeader) {
            _rj_tableView.mj_header = self.refreshHeader;
        }
        if (self.rj_isShowRefreshFooter) {
            _rj_tableView.mj_footer = self.refreshFooter;
        }
    }
    return _rj_tableView;
}
- (UITableViewStyle)rj_tableViewStyle {
    return UITableViewStyleGrouped;
}
- (RJEmptyViewType)rj_emptyViewType {
    return RJEmptyViewType_NoData;
}
- (void)rj_emptyViewRetry {
    [self rj_loadNewData];
    NSLog(@"____%s",__func__);
    NSLog(@"____%s",__func__);
}
#pragma mark - Subclass Override
- (RJRefreshHeader *)refreshHeader {
    if (!_refreshHeader) {
        _refreshHeader = [RJRefreshHeader headerWithRefreshingTarget:self
                                                    refreshingAction:@selector(rj_loadNewData)];
    }
    return _refreshHeader;
}

- (RJRefreshFooter *)refreshFooter {
    if (!_refreshFooter) {
        _refreshFooter = [RJRefreshFooter footerWithRefreshingTarget:self
                                                    refreshingAction:@selector(rj_loadMoreData)];
    }
    return _refreshFooter;
}
- (void)rj_loadNewData {
//    _currentPage = 1;
//    [self getList];
    [HUDManager showHUDAddedToView:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.rj_tableView.mj_header endRefreshing];
        //[self.rj_dataArray removeAllObjects];
        [self rj_reloadData];
    });
}

- (void)rj_loadMoreData {
//    _currentPage ++;
//    [self getList];
    
    [HUDManager showHUDAddedToView:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.rj_tableView.mj_footer endRefreshing];
        [self.rj_dataArray addObjectsFromArray:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]];
        [self rj_reloadData];
    });
}

- (void)rj_reloadData{
    [HUDManager hideHUDForView:self.view];
    
    [self.rj_tableView reloadData];
    [self.rj_tableView ly_endLoading];
}
@end
