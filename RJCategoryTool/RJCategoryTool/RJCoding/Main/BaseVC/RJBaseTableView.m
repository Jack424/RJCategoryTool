//
//  RJBaseTableView.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBaseTableView.h"

@implementation RJBaseTableView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[self superview] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}


@end
