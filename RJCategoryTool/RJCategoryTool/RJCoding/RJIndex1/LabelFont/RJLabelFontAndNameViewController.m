//
//  RJLabelFontAndNameViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/17.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJLabelFontAndNameViewController.h"
#import <CoreText/CoreText.h>

//Declaration of 'kCTFontNameAttribute' must be imported from module 'CoreText.CTFontDescriptor' before it is required
@interface RJLabelFontAndNameViewController ()
@end

@implementation RJLabelFontAndNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"字体";
    [self.rj_dataArray removeAllObjects];
    
    NSMutableArray *dataArray = UIFont.familyNames.mutableCopy;
    [dataArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    /*
     使用系统默认提供的字体,只针对英文数字，对中文无效
     */
    for (NSString *string in dataArray) {
        NSString *newString = string;//只对英文有效
//        newString = [newString stringByAppendingString:@" Medium"];
//        newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@"-"];
//        newString = [@"." stringByAppendingString:newString];
        [self.rj_dataArray addObject:newString];
    }
    NSLog(@"%@",self.rj_dataArray);
    [self.rj_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FontAndNameCell"];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"FontAndNameCell"];
    cell.textLabel.text = self.rj_dataArray[indexPath.row];
    cell.detailTextLabel.text = @"MyName";
    cell.detailTextLabel.font = [UIFont fontWithName:self.rj_dataArray[indexPath.row] size:18];
    
    cell.textLabel.font = [UIFont fontWithName:rj_kFontName size:18];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
};


@end
