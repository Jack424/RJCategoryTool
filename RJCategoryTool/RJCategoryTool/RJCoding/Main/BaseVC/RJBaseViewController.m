//
//  RJBaseViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBaseViewController.h"

@interface RJBaseViewController ()

@end

@implementation RJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rj_setUpSubviews];
}
-(void)rj_setUpSubviews {
    self.view.backgroundColor = rj_kColor_f3f6f6;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void)rj_setTransparentNavigationBackgrountImageAndShadowImage{
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}
-(void)dealloc {
    NSLog(@"dealloc/dealloc/dealloc-----%@",self.class);
}
@end
