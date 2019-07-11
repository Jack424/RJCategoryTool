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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.rj_tableView ly_startLoading];
}
- (void)rj_setUpSubviews {
    [super rj_setUpSubviews];
    [self.view addSubview:self.rj_tableView];
    [self.rj_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rj_dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifierWithIndexPath:indexPath] forIndexPath:indexPath];
    [self configureCell:cell
            atIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO;
}

- (NSString *)cellIdentifierWithIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:[self cellIdentifierWithIndexPath:indexPath]
                                    cacheByIndexPath:indexPath
                                       configuration:^(UITableViewCell *cell) {
                                           [self configureCell:cell
                                                   atIndexPath:indexPath];
                                       }];
    //return 50;
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
        _rj_tableView = [[RJBaseTableView alloc]initWithFrame:CGRectZero style:[self tableViewStyle]];
        _rj_tableView.backgroundColor = [UIColor clearColor];
        _rj_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rj_tableView.estimatedRowHeight = 0;
        _rj_tableView.estimatedSectionFooterHeight = 0;
        _rj_tableView.estimatedSectionHeaderHeight = 0;
        //weakify(self)
        rj_weakify(self)
        _rj_tableView.ly_emptyView = [RJEmptyView emptyViewWithType:[self emptyViewType]
                                                        tapBlock:^{
                                                            //strongify(self)
                                                            [RJWeak_self emptyViewRetry];
                                                        }];
        _rj_tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _rj_tableView.ly_emptyView.autoShowEmptyView = YES;
        _rj_tableView.delegate = self;
        _rj_tableView.dataSource = self;
        if(@available(iOS 11.0,*)) {
            _rj_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _rj_tableView.mj_header = self.refreshHeader;
        _rj_tableView.mj_footer = self.refreshFooter;
    }
    return _rj_tableView;
}
- (UITableViewStyle)tableViewStyle {
    return UITableViewStyleGrouped;
}
- (RJEmptyViewType)emptyViewType {
    return RJEmptyViewType_NoData;
}
- (void)emptyViewRetry {
    
}
#pragma mark - Subclass Override
- (RJRefreshHeader *)refreshHeader {
    if (!_refreshHeader) {
        _refreshHeader = [RJRefreshHeader headerWithRefreshingTarget:self
                                                    refreshingAction:@selector(loadNewData)];
    }
    return _refreshHeader;
}

- (RJRefreshFooter *)refreshFooter {
    if (!_refreshFooter) {
        _refreshFooter = [RJRefreshFooter footerWithRefreshingTarget:self
                                                    refreshingAction:@selector(loadMoreData)];
    }
    return _refreshFooter;
}
- (void)loadNewData {
//    _currentPage = 1;
//    [self getList];
}

- (void)loadMoreData {
//    _currentPage ++;
//    [self getList];
}
@end
