//
//  RJHorizontalImageNameLineButton.h
//  BMCityCon
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RJHorizontalImageNameLineButton : UIButton
- (instancetype)initWithFrame:(CGRect)frame  showLine:(BOOL)isShowLine;
- (instancetype)initWithFrame:(CGRect)frame  showLine:(BOOL)isShowLine clickBlock:(void(^)(void))clickBlock;
@end

NS_ASSUME_NONNULL_END
