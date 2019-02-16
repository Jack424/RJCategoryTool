//
//  GRJAdressPickerViewModel.h
//  HobayCn
//
//  Created by 易上云 on 2017/6/12.
//  Copyright © 2017年 Yi Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRJAdressPickerViewModel : NSObject
@property(nonatomic,copy)NSString *provinceName;// (string, optional): 省名 ,
@property(nonatomic,copy)NSString *cityName ;//(string, optional): 市名 ,
@property(nonatomic,copy)NSString *areaName;// (string, optional): 区名 ,

@property(nonatomic,copy)NSString *provinceCode;// (string, optional): 省编码 ,
@property(nonatomic,copy)NSString *cityCode ;//(string, optional): 市编码 ,
@property(nonatomic,copy)NSString *areaCode;// (string, optional): 区编码 ,
@end
