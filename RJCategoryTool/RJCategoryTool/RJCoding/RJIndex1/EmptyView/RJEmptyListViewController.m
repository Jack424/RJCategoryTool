//
//  RJEmptyListViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJEmptyListViewController.h"
#import "RJEmptyTestViewController.h"

@interface RJEmptyListViewController ()

@end

@implementation RJEmptyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"缺省页";
    self.dataSource = @[
                        @[@"请求空数据",@"MyName",@"nilData"],
                        @[@"网络错误"  ,@"MyName",@"network"],
                        @[@"重新加载"  ,@"MyName",@"reload"]
                        ];
}
-(void)nilData{
    RJEmptyTestViewController *subvc = [[RJEmptyTestViewController alloc]init];
    [self.navigationController pushViewController:subvc animated:YES];
}
-(void)network{
    RJEmptyTestViewController *subvc = [[RJEmptyTestViewController alloc]init];
    subvc.type = RJEmptyViewType_NetworkingError;
    [self.navigationController pushViewController:subvc animated:YES];
}
-(void)reload{
    RJEmptyTestViewController *subvc = [[RJEmptyTestViewController alloc]init];
    subvc.type = RJEmptyViewType_NoDataReload;
    [self.navigationController pushViewController:subvc animated:YES];
}

@end
