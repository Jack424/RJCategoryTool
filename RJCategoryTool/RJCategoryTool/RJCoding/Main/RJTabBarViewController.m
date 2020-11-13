//
//  RJTabBarViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJTabBarViewController.h"

@interface RJTabBarViewController ()

@end

@implementation RJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViewController];
}
-(void)setUpChildViewController {
    UIViewController *index1 = [self rj_addChildViewControllerWithClassString:@"RJIndex1TableViewController"];
    UIViewController *index2 = [self rj_addChildViewControllerWithClassString:@"RJIndex1TableViewController"];
    UIViewController *index3 = [self rj_addChildViewControllerWithClassString:@"RJIndex1TableViewController"];
    UIViewController *index4 = [self rj_addChildViewControllerWithClassString:@"RJIndex1TableViewController"];
    UIViewController *index5 = [self rj_addChildViewControllerWithClassString:@"RJIndex1TableViewController"];
    
    [self rj_setTabBarItemWithController:index1
                                   title:@"Home"
                               imageName:@"tabbar_home"
                       selectedImageName:@"tabbar_home_sel"];
    [self rj_setTabBarItemWithController:index2
                                   title:@"Home"
                               imageName:@"tabbar_home"
                       selectedImageName:@"tabbar_home_sel"];
    [self rj_setTabBarItemWithController:index3
                                   title:@"Home"
                               imageName:@"tabbar_home"
                       selectedImageName:@"tabbar_home_sel"];
    [self rj_setTabBarItemWithController:index4
                                   title:@"Home"
                               imageName:@"tabbar_home"
                       selectedImageName:@"tabbar_home_sel"];
    [self rj_setTabBarItemWithController:index5
                                   title:@"Home"
                               imageName:@"tabbar_home"
                       selectedImageName:@"tabbar_home_sel"];
}

-(UIViewController *)rj_addChildViewControllerWithClassString:(NSString *)classString {
    UIViewController *viewController = [[NSClassFromString(classString) alloc] init];
    UINavigationController  *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    [self addChildViewController:nav];
    return viewController;
}
-(void)rj_setTabBarItemWithController:(UIViewController *)controller
                                title:(NSString *)title
                            imageName:(NSString *)imageName
                    selectedImageName:(NSString *)selectedImageName {
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageWithOriginalImageName:imageName];//[UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [UIImage imageWithOriginalImageName:selectedImageName];
}


@end
