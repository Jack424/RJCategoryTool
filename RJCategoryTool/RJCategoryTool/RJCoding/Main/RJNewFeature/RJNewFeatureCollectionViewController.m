//
//  RJNewFeatureCollectionViewController.m
//  BMCityCon
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import "RJNewFeatureCollectionViewController.h"
#import "RJNewFeatureCollectionViewCell.h"

#define HCItemCount 3
@interface RJNewFeatureCollectionViewController ()
//上一个offsetX
@property (nonatomic, assign)CGFloat preOffsetX;

/** 注释*/
@property (nonatomic ,weak) UIImageView *guide;
@end

@implementation RJNewFeatureCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
    //[[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:XMGVersion];
    
    //1.UICollectionView创建时必须得要指定布局方式
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    //设置每一个格子的大小
    flowL.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //设置最小的行间距
    flowL.minimumLineSpacing = 0;
    //设置每个格子之间的距离
    flowL.minimumInteritemSpacing = 0;
    //设置滚动的方向
    flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:flowL];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[RJNewFeatureCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    
}
#pragma mark <UICollectionViewDataSource>

//每一组有多个个格子(item)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return HCItemCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RJNewFeatureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = @"rj_flower";
    
    cell.image = [UIImage imageNamed:imageName];
    cell.backgroundColor = [UIColor redColor];
    
    //添加立即体验
    [cell setStartBtn:indexPath count:HCItemCount];
    
    return cell;
}
@end
