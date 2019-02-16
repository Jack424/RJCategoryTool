//
//  GRJDatePickerView.h
//  HobayCn
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 Yi Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum{
    DateStyleShowYearMonthDayHourMinute  = 0,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowYearMonthDay,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute,
    DateStyleShowYearMonth
    
}GRJDateStyle;

@interface GRJDatePickerView : UIView

@property (nonatomic,strong)UIColor *doneButtonColor;//按钮颜色

@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认9999）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认0）



-(instancetype)initWithDateStyle:(GRJDateStyle)datePickerStyle CompleteBlock:(void(^)(NSDate *))completeBlock;

-(void)show;



@end
