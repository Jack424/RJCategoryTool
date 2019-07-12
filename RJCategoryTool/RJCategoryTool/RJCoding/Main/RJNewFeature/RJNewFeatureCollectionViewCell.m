//
//  RJNewFeatureCollectionViewCell.m
//  BMCityCon
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import "RJNewFeatureCollectionViewCell.h"
#import "RJRootVCTool.h"
@interface RJNewFeatureCollectionViewCell()

@property (nonatomic ,weak)UIImageView *imageV;
/** 注释*/
@property (nonatomic ,weak)UIButton *startBtn;

@end

@implementation RJNewFeatureCollectionViewCell
- (UIImageView *)imageV {
    if (_imageV == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = self.bounds;
        [self.contentView addSubview:imageV];
        _imageV = imageV;
    }
    return _imageV;
}
- (UIButton *)startBtn {
    if (_startBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[btn setImage:[UIImage imageNamed:@"3B5E727C2E02493443CE6A6DFD3A77D4"] forState:UIControlStateNormal];
        //先去自适应大小
        //[btn sizeToFit];
        btn.grj_size = CGSizeMake(200, 100);
        //设置位置
        btn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.9);
        [self.contentView addSubview:btn];
        
        //监听按钮的点击
        [btn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _startBtn = btn;
    }
    return _startBtn;
}
/**
 *  立即体验按钮的点击
 */
- (void)startBtnClick {
    //切换程序的主框架
    //如果相同,进入程序的主框架
    UIViewController *tabBarVc = [NSClassFromString(rjHomeVC) new];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    
    //保存当前版本
    NSString *curVersion =  [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:GRJVersion];
}
- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageV.image = image;
}
/**
 *  添加立即体验
 *
 *  @param indexPath 当前是第几个格子
 *  @param count     格子的总个数
 */
- (void)setStartBtn:(NSIndexPath *)indexPath count:(int)count {
    if (indexPath.item == count - 1) {
        self.startBtn.hidden = NO;
    }else {
        //隐藏开始按钮
        self.startBtn.hidden = YES;
    }
}
@end
