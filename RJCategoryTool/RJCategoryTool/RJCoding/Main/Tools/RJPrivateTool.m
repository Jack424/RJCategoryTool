//
//  RJPrivateTool.m
//  RJCategoryTool
//
//  Created by JinTian on 2019/9/17.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJPrivateTool.h"

@implementation RJPrivateTool
+(UIImage *)rjp_randomImage{
    return [UIImage imageNamed:[NSString stringWithFormat:@"rj_theme_picture_%d",arc4random() % 29 + 1]];
}
+(NSString *)rjp_randomImageName{
    return [NSString stringWithFormat:@"rj_theme_picture_%d",arc4random() % 29 + 1];
}
@end
