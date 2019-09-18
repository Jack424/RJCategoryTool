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
@interface RJIndex1TableViewController()<SDCycleScrollViewDelegate>
@property (strong ,nonatomic) UIView *alphaView;
@property (strong ,nonatomic) UIView *moveView;
@property (assign ,nonatomic) double beginY;
@end

@implementation RJIndex1TableViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [RJFontStylePostScriptDownload rj_downLoadFont:rj_kFontName];
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc]init];
    cycleScrollView.delegate = self;
    //cycleScrollView.imageURLStringsGroup = @[];
    cycleScrollView.localizationImageNamesGroup = @[[RJPrivateTool rjp_randomImageName],[RJPrivateTool rjp_randomImageName],[RJPrivateTool rjp_randomImageName],[RJPrivateTool rjp_randomImageName],[RJPrivateTool rjp_randomImageName],[RJPrivateTool rjp_randomImageName]];
    cycleScrollView.placeholderImage = rj_IMAGE_NAMED(@"rj_flower");
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.frame = CGRectMake(0, 0, 0, 180);
    self.rj_tableView.tableHeaderView = cycleScrollView;
    self.rj_tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
    [self.rj_tableView registerClass:[RJDisplayTableViewCell class] forCellReuseIdentifier:NSStringFromClass([RJDisplayTableViewCell class])];
    
    self.alphaView = [[UIView alloc]init];
    self.alphaView.layer.cornerRadius = 20;
    self.alphaView.frame = CGRectMake(100, rj_kScreenHeight-200, 40, 40);
    self.alphaView.backgroundColor = rj_kColor_41AAEC;
    [self.view addSubview:self.alphaView];
    
    self.moveView = [[UIView alloc]init];
    self.moveView.layer.cornerRadius = 20;
    self.moveView.frame = CGRectMake(rj_kScreenWidth - 100 - 40, rj_kScreenHeight-200, 40, 40);
    self.moveView.backgroundColor = rj_kColor_41AAEC;
    [self.view addSubview:self.moveView];
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.beginY = scrollView.contentOffset.y;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (scrollView.contentOffset.y < self.beginY ){
            //向上
            [UIView animateWithDuration:0.5 animations:^{
                self.moveView.grj_top = rj_kScreenHeight-200;
                self.alphaView.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                self.moveView.grj_top = rj_kScreenHeight;
                self.alphaView.alpha = 0;
            } completion:^(BOOL finished) {
            }];
        }
    });
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
        subcell.imageV.image = [RJPrivateTool rjp_randomImage];
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
