//
//  RJBaseTableViewCell.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBaseTableViewCell.h"

@implementation RJBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self rj_setTableViewCell];
    }
    return self;
}

-(void)rj_setTableViewCell{
    
}

@end
