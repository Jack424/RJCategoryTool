//
//  RJBaseView.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBaseView.h"

@implementation RJBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self rj_setUIView];
    }
    return self;
}
-(void)rj_setUIView{
    
}
@end
