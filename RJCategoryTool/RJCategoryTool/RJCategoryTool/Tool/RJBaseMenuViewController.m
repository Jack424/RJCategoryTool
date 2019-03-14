//
//  RJBaseMenuViewController.m
//  BMCityCon
//
//  Created by apple on 2018/12/20.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import "RJBaseMenuViewController.h"
static NSString * const ID = @"cell";

#import "UIButton+Badge.h"
#import "Masonry.h"
#import "RJColorAndFont.h"
#import "RJMainMacros.h"
#import "UIView+GRJFrame.h"
#import "NSString+RJString.h"

@interface RJBaseMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UIScrollView *topView;
@property (nonatomic, weak) UIButton *selButton;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, weak) UIView *underLineView;
@property (nonatomic, assign) BOOL isInitial;

@end

@implementation RJBaseMenuViewController

- (NSMutableArray *)titleButtons{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_titleLineColor) {
        _titleLineColor = rj_kColor_ff4b00;
    }
    
    [self setupTopView];
    [self setupBottomView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isInitial == NO) {
        // 设置所有标题
        [self setupAllTitle];
        _isInitial = YES;
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childViewControllers.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = rj_kColor_eeeeee;
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIViewController *vc = self.childViewControllers[indexPath.row];
    [cell.contentView addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    return cell;
}

// 设置所有标题
- (void)setupAllTitle{
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = rj_kScreenWidth / count;
    CGFloat btnH = _topView.grj_height;
    if (count>5) {
        btnW = rj_kScreenWidth / 5;
    }
    _topView.contentSize = CGSizeMake(btnW*count, 0);
    CGFloat btnX = 0;
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        btnX = i * btnW;
        titleButton.tag = i;
        titleButton.frame = CGRectMake(btnX, 0, btnW, btnH);
        NSString *title = [self.childViewControllers[i] title];
        [titleButton setTitle:title forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:_titleLineColor forState:UIControlStateSelected];
        
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        
        // 1 设置红点
        [self rj_setIsHasRedPointWithButton:titleButton tag:i];
        
        // 2 默认选中第几个按钮
        [self rj_setSelectedButtonWithButton:titleButton tag:i title:title];
    }
}
-(void)rj_setSelectedButtonWithButton:(UIButton *)titleButton tag:(int)i title:(NSString *)title{
    if (i == self.jumpType) {
        [self titleClick:titleButton];
        
        UIView *underLineView = [[UIView alloc] init];
        underLineView.backgroundColor = _titleLineColor;
        // 注意：设置中心点，一点要先设置尺寸
        underLineView.grj_width = [title boundingRectWithSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX}
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                      context:nil].size.width;
        underLineView.grj_centerX = titleButton.grj_centerX;
        
        underLineView.grj_height = 2;
        underLineView.grj_top = _topView.grj_height - underLineView.grj_height;
        [_topView addSubview:underLineView];
        _underLineView = underLineView;
    }
}
-(void)rj_setIsHasRedPointWithButton:(UIButton *)titleButton tag:(int)i{
    if (self.isHasRedPoint && i>0) {
        titleButton.badgeValue = [NSString stringWithFormat:@"2"];
        titleButton.badgeFont      = rj_kFont_08;
        titleButton.badgeMinSize   =  6;
        
        if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)) {//iPhone6Plus
            titleButton.badgeOriginX   = (90);
        }else{
            titleButton.badgeOriginX   = (84);
        }
        titleButton.badgeOriginY   = 12;
        titleButton.badgePadding   =  1;
        titleButton.badgeTextColor = rj_kColor_ff353e;
    }
}

-(void)change_titleWithArray:(NSArray <NSString *>*)titleArray{
    if (self.titleButtons.count==titleArray.count) {
        for (int i = 0; i < self.titleButtons.count; i ++) {
            UIButton *button = self.titleButtons[i];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
        }
    }
}
-(void)change_title:(NSString *)title index:(NSInteger)index{
    if ((index<self.titleButtons.count)&&(![NSString rj_stringIsEmpty:title])) {
        UIButton *button = self.titleButtons[index];
        [button setTitle:title forState:UIControlStateNormal];
    }
}
#pragma mark - 点击标题就会调用
- (void)titleClick:(UIButton *)button{
    NSInteger i = button.tag;
    [self selButton:button];
    CGFloat offsetX = i * rj_kScreenWidth;
    _collectionView.contentOffset = CGPointMake(offsetX, 0);
    
    self.seletedButtpnTag = button.tag;
}

#pragma mark - 选中按钮
- (void)selButton:(UIButton *)button{
    if (self.isHasRedPoint && button.tag>0) {
        button.badgeValue = [NSString stringWithFormat:@"0"];
    }
    _selButton.selected = NO;
    button.selected = YES;
    _selButton = button;
    
    if (_titleClick) {
        _titleClick(button.tag);
    }
    // 移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        _underLineView.grj_centerX = button.grj_centerX;
        if (self.childViewControllers.count>5) {
            if (button.tag>2&&(button.tag<self.childViewControllers.count-2)) {
                self.topView.contentOffset = CGPointMake((button.tag-2)*rj_kScreenWidth / 5, 0);
            }else{
                if (button.tag<=2) {
                    self.topView.contentOffset = CGPointMake(0, 0);
                }else{
                    self.topView.contentOffset = CGPointMake((self.childViewControllers.count-5)*rj_kScreenWidth / 5, 0);
                }
            }
        }
    }];
}

- (void)setupTopView{
    UIScrollView *topView = [[UIScrollView alloc] init];
    topView.scrollsToTop = NO;
    _topView = topView;
    topView.backgroundColor = [UIColor whiteColor];
    CGFloat topY  = 0;
    CGFloat topH = 44;
    CGFloat topW = rj_kScreenWidth;
    topView.frame = CGRectMake(0, topY, topW, topH);
    topView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:topView];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor  = [UIColor groupTableViewBackgroundColor];
    lineView.frame = CGRectMake(0, 43, rj_kScreenWidth, 1);
    [topView addSubview:lineView];
}
- (void)setupBottomView{
    // 设置布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    if (rj_kIsiPhoneX) {
        layout.itemSize = CGSizeMake(rj_kScreenWidth, self.view.bounds.size.height - 88 - 34 - 44);//kMainScreenHeight
    }else{
        layout.itemSize = CGSizeMake(rj_kScreenWidth, self.view.bounds.size.height - 64 - 44);//kMainScreenHeight
    }
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    NSLog(@"cell高度-=---%f",self.view.bounds.size.height);
    // 指示器，cell间距，分页
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.scrollsToTop = NO;
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.bounces = NO;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    
    if (rj_kIsiPhoneX) {
        collectionView.frame = CGRectMake(0, 44, rj_kScreenWidth, self.view.bounds.size.height - 88 - 34 - 44);
    }else{
        collectionView.frame = CGRectMake(0, 44, rj_kScreenWidth, self.view.bounds.size.height - 64 - 44);
    }
    // 注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}
#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger i = scrollView.contentOffset.x / rj_kScreenWidth;
    // 选中对应的标题
    if (self.titleButtons.count <= 0) {
        return;
    }
    [self selButton:self.titleButtons[i]];
    
}


@end
