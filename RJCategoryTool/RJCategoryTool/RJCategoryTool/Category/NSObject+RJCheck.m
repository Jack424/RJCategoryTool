//
//  NSObject+RJCheck.m
//  BMCityCon
//
//  Created by apple on 2018/12/20.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#import "NSObject+RJCheck.h"

@implementation NSObject (RJCheck)
+ (BOOL)rj_objIsEmpty:(id)object {
    return ([object isKindOfClass:[NSNull class]] || object == nil);
}


@end
