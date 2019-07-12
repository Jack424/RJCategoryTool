//
//  RJModuleEntranceCollectionViewLayout.h
//  RJCategoryTool
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJModuleEntranceCollectionViewLayout : UICollectionViewLayout
@property (nonatomic, assign) IBInspectable NSUInteger columns;     // default 4
@property (nonatomic, assign) IBInspectable NSUInteger rows;        // default 2
@property (nonatomic, assign) IBInspectable CGSize itemSize;        // default {64, 64}
@property (nonatomic, assign) IBInspectable UIEdgeInsets edgeInsets;// default {8, 8, 8, 8}
@end

NS_ASSUME_NONNULL_END
