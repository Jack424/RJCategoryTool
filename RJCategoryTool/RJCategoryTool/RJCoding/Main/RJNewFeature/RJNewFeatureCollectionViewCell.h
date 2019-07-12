//
//  RJNewFeatureCollectionViewCell.h
//  BMCityCon
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJNewFeatureCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImage *image;

/**
 *  添加立即体验
 *
 *  @param indexPath 当前是第几个格子
 *  @param count     格子的总个数
 */
- (void)setStartBtn:(NSIndexPath *)indexPath count:(int)count;
@end

NS_ASSUME_NONNULL_END
