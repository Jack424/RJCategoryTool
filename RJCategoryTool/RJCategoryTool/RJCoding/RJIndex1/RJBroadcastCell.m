//
//  RJBroadcastCell.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBroadcastCell.h"
#import "RJBroadcastView.h"


@implementation RJBroadcastCell

-(void)rj_setTableViewCell{
    RJBroadcastView *view = [[RJBroadcastView alloc]init];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    view.cellHight = 40;
    view.titleArray = @[@"信不由中，质无益也。",
                        @"明恕而行，要之以礼，虽无有质，谁能间之？",
                        @"苟有明信，涧溪沼沚之毛，蘋蘩蕴藻之菜.",
                        @"筐筥錡釜之器，潢污行潦之水，可荐于鬼神，可羞于王公",
                        @"而况君子结二国之信，行之以礼，又焉用质?",
                        @"《风》有《采蘩》、《采蘋》，《雅》有《行苇》、《泂酌》，昭忠信也。",
                        ];
}

@end
