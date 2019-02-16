//
//  RJBaseMenuViewController.h
//  BMCityCon
//
//  Created by apple on 2018/12/20.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJBaseMenuViewController : UIViewController
@property (nonatomic, assign) NSInteger seletedButtpnTag;


@property(nonatomic,assign)NSInteger jumpType;  //默认 0(可不传)   跳转其他菜单传 1  2  3  4  5

@property(nonatomic,assign)BOOL isHasRedPoint;  //有需要带红点的传YES   默认为NO 三菜单选择类目中使用过

@property (nonatomic, weak) UICollectionView *collectionView; //pw 换到外面

@property(nonatomic,strong) void(^titleClick)(NSInteger index);//点击了某一个按钮

-(void)change_titleWithArray:(NSArray <NSString *>*)titleArray;

-(void)change_title:(NSString *)title index:(NSInteger)index;
@end
