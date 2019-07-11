//
//  UIViewController+RTRootNav.m
//  BMCityCon
//
//  Created by apple on 2019/3/14.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import "UIViewController+RTRootNav.h"

@implementation UIViewController (RTRootNav)

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target
                                          action:(SEL)action {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 25.0, 35.0);
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backButton addTarget:target
                   action:action
         forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:backButton];
}



@end
