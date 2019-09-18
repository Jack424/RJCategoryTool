//
//  RJModuleEntranceCell.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJModuleEntranceCell.h"
#import "RJModuleEntranceCollectionViewCell.h"
#import "RJModuleEntranceCollectionViewLayout.h"

#import "RJPayViewController.h"
#import "RJEmptyListViewController.h"
#import "RJVideoEditViewController.h"
#import "RJLabelFontAndNameViewController.h"
#import "RJArraysortingViewController.h"

@interface RJModuleEntranceCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (strong ,nonatomic) NSMutableArray *dataArray;
@end
@implementation RJModuleEntranceCell
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"支付"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"缺省页"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"视频"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"字体"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"数组排序"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"},
                       @{@"image":[RJPrivateTool rjp_randomImageName],@"title":@"模块"}
                       ].mutableCopy;
    }
    return _dataArray;
}
-(void)rj_setTableViewCell{
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
#pragma mark -- UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
//返回item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RJModuleEntranceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RJModuleEntranceCollectionViewCell" forIndexPath:indexPath];
    cell.dataDict = self.dataArray[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.dataArray[indexPath.row][@"title"] isEqualToString:@"支付"]) {
        RJPayViewController *subvc = [[RJPayViewController alloc]init];
        [[RJInitViewTool rj_getNavigationControllerFromView:self] pushViewController:subvc animated:YES];
    }
    if ([self.dataArray[indexPath.row][@"title"] isEqualToString:@"缺省页"]) {
        RJEmptyListViewController *subvc = [[RJEmptyListViewController alloc]init];
        [[RJInitViewTool rj_getNavigationControllerFromView:self] pushViewController:subvc animated:YES];
    }
    if ([self.dataArray[indexPath.row][@"title"] isEqualToString:@"视频"]) {
        RJVideoEditViewController *subvc = [[RJVideoEditViewController alloc]init];
        [[RJInitViewTool rj_getNavigationControllerFromView:self] pushViewController:subvc animated:YES];
    }//
    if ([self.dataArray[indexPath.row][@"title"] isEqualToString:@"字体"]) {
        RJLabelFontAndNameViewController *subvc = [[RJLabelFontAndNameViewController alloc]init];
        [[RJInitViewTool rj_getNavigationControllerFromView:self] pushViewController:subvc animated:YES];
    }
    if ([self.dataArray[indexPath.row][@"title"] isEqualToString:@"数组排序"]) {
        RJArraysortingViewController *subvc = [[RJArraysortingViewController alloc]init];
        [[RJInitViewTool rj_getNavigationControllerFromView:self] pushViewController:subvc animated:YES];
    }
}
// 在开始移动时会调用此代理方法，
-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
// 在移动结束的时候调用此代理方法
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSLog(@"123123123123123");
}
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    CGPoint point = [longPress locationInView:_collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            if (!indexPath) {
                break;
            }
            BOOL canMove = [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            if (!canMove) {
                break;
            }
            break;
        case UIGestureRecognizerStateChanged:
            [_collectionView updateInteractiveMovementTargetPosition:point];
            break;
        case UIGestureRecognizerStateEnded:
            [_collectionView endInteractiveMovement];
            break;
        default:
            [_collectionView cancelInteractiveMovement];
            break;
    }
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        RJModuleEntranceCollectionViewLayout *flowLayout = [[RJModuleEntranceCollectionViewLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[RJModuleEntranceCollectionViewCell class] forCellWithReuseIdentifier:@"RJModuleEntranceCollectionViewCell"];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_collectionView addGestureRecognizer:longPressGesture];
        
    }
    return _collectionView;
}


@end
