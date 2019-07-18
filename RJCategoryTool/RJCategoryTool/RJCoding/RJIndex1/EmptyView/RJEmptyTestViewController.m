//
//  RJEmptyTestViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJEmptyTestViewController.h"
#import "RJDisplayTableViewCell.h"


@interface RJEmptyTestViewController ()

@end

@implementation RJEmptyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"缺省页";

    [self.rj_tableView registerClass:[RJDisplayTableViewCell class] forCellReuseIdentifier:NSStringFromClass([RJDisplayTableViewCell class])];
}
-(RJEmptyViewType)rj_emptyViewType{
    return self.type;
}
-(BOOL)rj_isShowRefreshHeader{
    return YES;
}
-(BOOL)rj_isShowRefreshFooter{
    return YES;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RJDisplayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RJDisplayTableViewCell class])];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
@end
