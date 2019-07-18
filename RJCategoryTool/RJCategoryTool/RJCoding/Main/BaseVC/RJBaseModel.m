//
//  RJBaseModel.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJBaseModel.h"

@implementation RJBaseModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"_id":@"id"};
}
@end
