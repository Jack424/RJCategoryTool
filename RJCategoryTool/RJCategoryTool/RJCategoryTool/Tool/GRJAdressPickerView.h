//
//  GRJAdressPickerView.h
//  HobayCn
//
//  Created by 易上云 on 2017/6/12.
//  Copyright © 2017年 Yi Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRJAdressPickerViewModel.h"

@interface GRJAdressPickerView : UIView
@property(nonatomic,strong)void(^choiceBlock)(GRJAdressPickerViewModel *model);
@property(nonatomic,copy)NSString *province;// (string, optional): 省名 ,
@property(nonatomic,copy)NSString *city ;//(string, optional): 市名 ,
@property(nonatomic,copy)NSString *area;// (string, optional): 区名 ,
-(void)showPickerView;
@end
