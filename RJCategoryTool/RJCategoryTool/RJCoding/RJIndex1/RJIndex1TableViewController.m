//
//  RJIndex1TableViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJIndex1TableViewController.h"
#import "RJModuleEntranceCell.h"
#import "RJBroadcastCell.h"
#import "RJDisplayTableViewCell.h"

@implementation RJIndex1TableViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [RJFontStylePostScriptDownload rj_downLoadFont:rj_kFontName];
}
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
    self.rj_tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
    [self.rj_tableView registerClass:[RJDisplayTableViewCell class] forCellReuseIdentifier:NSStringFromClass([RJDisplayTableViewCell class])];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return 15;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    if (indexPath.section==0) {
        RJModuleEntranceCell *subcell = [[RJModuleEntranceCell alloc]init];
        cell = subcell;
    }else if(indexPath.section==1){
        RJBroadcastCell *subcell = [[RJBroadcastCell alloc]init];
        cell = subcell;
    }else if(indexPath.section==2){
        RJDisplayTableViewCell *subcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RJDisplayTableViewCell class])];
        cell = subcell;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 160;
    }else if(indexPath.section==1){
        return 40;
    }else if(indexPath.section==2){
        return 120;
    }
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

@end
