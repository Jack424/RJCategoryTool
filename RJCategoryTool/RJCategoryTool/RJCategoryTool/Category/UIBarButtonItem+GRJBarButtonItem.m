//
//  UIBarButtonItem+GRJBarButtonItem.m
//  GRJTolCayFrwk
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 Global Barter. All rights reserved.
//

#import "UIBarButtonItem+GRJBarButtonItem.h"


@implementation UIBarButtonItem (GRJBarButtonItem)


+ (UIBarButtonItem *)item:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
   // [btn setTitle:@"    " forState:UIControlStateNormal];
    //    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    //    [containView addSubview:btn];
    // 把按钮包装成UIBarButtonItem，点击范围扩大，把按钮放在UIView,在把UIView包装成UIBarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)item:(UIImage *)image highImage:(UIImage *)highImage target:( id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"" forState:UIControlStateNormal];
    //    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    //    [containView addSubview:btn];
    //btn.imageEdgeInsets = UIEdgeInsetsMake(17, 8, 18, 10);
    // 把按钮包装成UIBarButtonItem，点击范围扩大，把按钮放在UIView,在把UIView包装成UIBarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



+ (UIBarButtonItem *)item:(UIImage *)image highImageLimit:(UIImage *)highImage target:( id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    //    [containView addSubview:btn];
    
    // 把按钮包装成UIBarButtonItem，点击范围扩大，把按钮放在UIView,在把UIView包装成UIBarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    
    // 设置按钮的尺寸为背景图片的尺寸
    CGRect frame = button.frame ;
    frame.size = button.currentBackgroundImage.size;
    button.frame = frame;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

//设置全局的UIBarButtonItem
+ (UIBarButtonItem *)itemWithBarButtonItem:(UIBarButtonItem *)barButtonItem{
    //设置导航条右边文字
    [barButtonItem setTintColor:[UIColor redColor]];
    [barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    return  barButtonItem;
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    return [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}
@end
