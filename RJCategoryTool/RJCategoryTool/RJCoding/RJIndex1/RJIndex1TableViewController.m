//
//  RJIndex1TableViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJIndex1TableViewController.h"
#import "RJModuleEntranceCell.h"


@implementation RJIndex1TableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc]init];
    //cycleScrollView.imageURLStringsGroup = @[];
    cycleScrollView.localizationImageNamesGroup = @[@"rj_flower",@"rj_flower",@"rj_flower",@"rj_flower",@"rj_flower"];
    cycleScrollView.placeholderImage = rj_IMAGE_NAMED(@"rj_flower");
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.frame = CGRectMake(0, 0, 0, 180);
    self.rj_tableView.tableHeaderView = cycleScrollView;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RJModuleEntranceCell *cell = [[RJModuleEntranceCell alloc]init];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

@end
