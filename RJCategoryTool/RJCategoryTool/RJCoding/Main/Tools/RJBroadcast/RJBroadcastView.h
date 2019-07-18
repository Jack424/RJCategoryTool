//
//  RJBroadcastView.h
//  RJCategoryTool
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJBroadcastView : RJBaseView
@property (nonatomic,assign) CGFloat cellHight;//先设置cellHight 再设置titleArray

@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *modelArray;//首页广播数据源
@end

NS_ASSUME_NONNULL_END
