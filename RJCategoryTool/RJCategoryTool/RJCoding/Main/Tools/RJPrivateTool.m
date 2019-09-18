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
    return [UIImage imageNamed:[NSString stringWithFormat:@"JangNaRa_%d",arc4random() % 28 + 1]];
}
+(NSString *)rjp_randomImageName{
    return [NSString stringWithFormat:@"JangNaRa_%d",arc4random() % 28 + 1];
}
@end
