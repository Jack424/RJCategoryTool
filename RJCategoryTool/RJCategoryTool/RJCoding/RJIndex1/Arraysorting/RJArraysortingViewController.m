//
//  RJArraysortingViewController.m
//  RJCategoryTool
//
//  Created by JinTian on 2019/8/28.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJArraysortingViewController.h"
#import "RJArraysortingModel.h"

@interface RJArraysortingViewController ()
@property (strong ,nonatomic) NSMutableArray *modelArray;
@end

@implementation RJArraysortingViewController
-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = @[].mutableCopy;
    }
    return _modelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"数组排序";
    
    [self setDataSource];
}
-(void)setDataSource{
    NSArray *idArray = @[@"1", @"4", @"3", @"2", @"8", @"9", @"5", @"6", @"11", @"7", @"10", @"12", @"18", @"19", @"20"];
    NSArray *ageArray = @[@16, @32, @45, @22, @32, @27, @15, @22, @55, @34, @32, @22, @24, @18, @12];
    NSArray *heightArray = @[@100, @166, @180, @165, @163, @176, @174, @183, @186, @178, @167, @160, @160, @160, @160];
    for (int i = 0; i<idArray.count; i++) {
        RJArraysortingModel *model = [[RJArraysortingModel alloc]init];
        model.uid    = idArray[i];
        model.age    = [ageArray[i] intValue];
        model.height = [heightArray[i] doubleValue];
        [self.modelArray addObject:model];
    }
    NSLog(@"---------  数据源  ---------");
    for (RJArraysortingModel *model in self.modelArray) {
        NSLog(@"age: %d   height: %.0f   uid: %@", model.age,model.height, model.uid);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //NSEnumerator  倒叙
    NSLog(@"---------  倒1叙  ---------");
    NSArray *daoXuArray = (NSArray *)[[self.modelArray reverseObjectEnumerator] allObjects];
    for (RJArraysortingModel *model in daoXuArray) {
        NSLog(@"age: %d   height: %.0f   uid: %@", model.age,model.height, model.uid);
    }
    NSLog(@"---------  倒2叙  ---------");
    NSArray *resultDescendArray = [self.modelArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return  NSOrderedDescending; // 数组逆转
        //return NSOrderedAscending;  // 数组不变
    }];
    for (RJArraysortingModel *model in resultDescendArray) {
        NSLog(@"age: %d   height: %.0f   uid: %@", model.age,model.height, model.uid);
    }
    //int, double等 就需要对将其转化为NSNumber类型  (字符串数字不能当字符串处理)
    NSLog(@"---------  按id值排序  ---------");
    NSArray *resultArray = [self.modelArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        RJArraysortingModel *model1 = obj1;
        RJArraysortingModel *model2 = obj2;
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *num1 = [numberFormatter numberFromString:model1.uid];
        NSNumber *num2 = [numberFormatter numberFromString:model2.uid];
        
        NSComparisonResult result = [num1 compare:num2];
        
        return  result == NSOrderedDescending; // 升序
        //return  result == NSOrderedSame; // 不变
        //return result == NSOrderedAscending;  // 降序
    }];
    for (RJArraysortingModel *model in resultArray) {
        NSLog(@"age: %d   height: %.0f   uid: %@", model.age,model.height, model.uid);
    }
    
    
    NSLog(@"---------  按身高值排序  ---------");
    NSArray *resultArray2 = [self.modelArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        RJArraysortingModel *model1 = obj1;
        RJArraysortingModel *model2 = obj2;
        
        NSNumber *num1 = [NSNumber numberWithDouble:model1.height];
        NSNumber *num2 = [NSNumber numberWithDouble:model2.height];
        NSComparisonResult result = [num1 compare:num2];
        
        if (result == NSOrderedSame) {
            NSLog(@"重复啦------%@",num1);
            NSNumber *num1 = [NSNumber numberWithInt:model1.age];
            NSNumber *num2 = [NSNumber numberWithInt:model2.age];
            NSComparisonResult result = [num1 compare:num2];
            
            return  result == NSOrderedDescending; // 升序
        }else{
            return  result == NSOrderedDescending; // 升序
        }
        //return result == NSOrderedAscending;  // 降序
        //return  result == NSOrderedDescending; // 升序
        //return  result == NSOrderedSame; // 不变
    }];
    for (RJArraysortingModel *model in resultArray2) {
        NSLog(@"age: %d   height: %.0f   uid: %@", model.age,model.height, model.uid);
    }
    
    
    //字符串数组
    NSLog(@"---------  名字数据源  ---------");
    NSMutableArray *nameArray = @[@"Smith",@"Bohn",@"aohn",@"john"].mutableCopy;
    NSLog(@"---------  %@  ---------",nameArray);
    
    NSArray *resultNameArray = [nameArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    NSLog(@"---------  名字排序  ---------");
    for (NSString *name in resultNameArray) {
        NSLog(@"name: %@",name);
    }
}


@end
