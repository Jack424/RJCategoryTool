//
//  RJBaseListTableViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBaseListTableViewController.h"

@interface RJBaseListTableViewController ()

@end

@implementation RJBaseListTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setUpBack];
    
    if (!_dataSource) {
        _dataSource = @[
                        @[@"标题",@"名字",@"methadName"],
                        ];
    }
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(void)setUpBack{
    // 1 设置背景图片
    UIImageView *backImageView = [RJInitViewTool rj_initImageViewWithSuperView:self.view];
    _backImageView = backImageView;
    backImageView.image = kRJPlaceholderImage;
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    backImageView.clipsToBounds = YES;
    backImageView.frame = self.view.bounds;
    [self.view addSubview:backImageView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"list"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [_dataSource[indexPath.row] firstObject];
    cell.detailTextLabel.text = _dataSource[indexPath.row][1];
    cell.detailTextLabel.textColor = [UIColor orangeColor];
    cell.detailTextLabel.font = rj_kFont_22;
    if ([cell.detailTextLabel.text containsString:@"red"]) {
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.detailTextLabel.text = [cell.detailTextLabel.text stringByReplacingOccurrencesOfString:@"red" withString:@""];
    }else{
        cell.textLabel.textColor = rj_kColor_333333;
    }
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                [self registerForPreviewingWithDelegate:(id)self sourceView:cell];
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SEL selector = NSSelectorFromString([self.dataSource[indexPath.row] lastObject]);
    //((void (*)(id,SEL))objc_msgSend)(self,selector);
    if ([self respondsToSelector:selector]) {
        ((void (*)(id,SEL))objc_msgSend)(self,selector);
    }else{
        [HUDManager showBriefAlert:@"还没实现方法呢!"];
    }
}
-(void)methadName{
    [HUDManager showBriefAlert:@"点我干啥嘞!"];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
