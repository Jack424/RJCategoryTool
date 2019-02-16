//
//  GRJAdressPickerView.m
//  HobayCn
//
//  Created by 易上云 on 2017/6/12.
//  Copyright © 2017年 Yi Cloud. All rights reserved.
//

#import "GRJAdressPickerView.h"
#import "UIView+GRJFrame.h"
#import "NSString+RJString.h"
#import "RJColorAndFont.h"
#import "RJMainMacros.h"


@interface GRJAdressPickerView ()<UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate>

/** 城市选择器 */


@property(nonatomic,copy)NSString *provinceCode;// (string, optional): 省编码 ,
@property(nonatomic,copy)NSString *cityCode ;//(string, optional): 市编码 ,
@property(nonatomic,copy)NSString *areaCode;// (string, optional): 区编码 ,

@property (strong, nonatomic)  UIPickerView *myPicker;
@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic)  UIView *pickerBgView;
@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *makeSureBtn;
@property(nonatomic,strong)UILabel *titleLabel;

@property (strong, nonatomic) NSMutableArray *provinceArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
@property (strong, nonatomic) NSMutableArray *townArray;

@property (strong, nonatomic) NSMutableArray *provinceCodeArray;
@property (strong, nonatomic) NSMutableArray *cityCodeArray;
@property (strong, nonatomic) NSMutableArray *townCodeArray;

@property (nonatomic, assign) NSInteger proviceIndex;
@property (nonatomic, assign) NSInteger cityIndex;
@property (nonatomic, assign) NSInteger areaIndex;

@property (strong, nonatomic) NSArray *allDataJson;//所有数据

/** 内容字体 */
@property (nonatomic, strong) UIFont *font;



/** 城市选择器 */
@end

@implementation GRJAdressPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

/*********************************************************************************/
/*********************************************************************************/

- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.maskView.alpha = 0;
        self.pickerBgView.grj_top = self.grj_height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}


-(void)cancelBtnClick{
    [self hideMyPicker];
}
-(void)makeSureBtnClick{
    NSLog(@"%@", [NSString stringWithFormat:@"%@%@%@",self.province,self.city,self.area]);
    
    GRJAdressPickerViewModel *model = [[GRJAdressPickerViewModel alloc]init];
    model.provinceName = self.province;
    model.cityName = self.city;
    model.areaName = self.area;
    model.provinceCode = self.provinceCode;
    model.cityCode = self.cityCode;
    model.areaCode = self.areaCode;
    if (_choiceBlock) {
        _choiceBlock(model);
    }
    
    [self hideMyPicker];
}

/******************************   弹出地址选择器    *********************************/

/***************************************************************/

/***************************************************************/


-(void)showPickerView{
    
    
    [self setUpPikerView];
    [self addSubview:self.maskView];
    [self addSubview:self.pickerBgView];
    self.maskView.alpha = 0.0;
    self.pickerBgView.grj_top = self.grj_height;
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.5;
        self.pickerBgView.grj_bottom = self.grj_height;
    }];
    
    [self upDataAddressData];
    
    [self scrollToPiceViewIndex];
}
/*****************************  关于城市选择器的代码    ********************************/
/*****************************      ********************************/
/*************************************************************/
/*************************************************************/
/**
 *  加载城市数据
 */
-(void)upDataAddressData{
    if (!self.allDataJson) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
        NSString *jsonStr  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSData *jaonData   = [[NSData alloc] initWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
        self.allDataJson = [NSJSONSerialization JSONObjectWithData:jaonData options:(NSJSONReadingMutableContainers) error:nil];
    }
    
    [self.provinceArray removeAllObjects];
    [self.provinceCodeArray removeAllObjects];
    [self.cityArray removeAllObjects];
    [self.cityCodeArray removeAllObjects];
    [self.townArray removeAllObjects];
    [self.townCodeArray removeAllObjects];
    
    //省
    for (NSDictionary *priovicedic in self.allDataJson) {
        [self.provinceArray addObject:priovicedic[@"province"]];
        [self.provinceCodeArray addObject:priovicedic[@"provinceCode"]];
        
        if ([NSString rj_stringIsEmpty:self.province]) {//未选择时默认第一个
            self.province = [self.provinceArray firstObject];
            self.provinceCode = [self.provinceCodeArray firstObject];
        }
    }
    
    //市
    
    if ([self.allDataJson[self.proviceIndex][@"citys"] count]) {
        for (NSDictionary *cityDic in self.allDataJson[self.proviceIndex][@"citys"]) {
            [self.cityArray addObject:cityDic[@"city"]];
            [self.cityCodeArray addObject:cityDic[@"cityCode"]];
            
        }
        if ([NSString rj_stringIsEmpty:self.city]) {//未选择时默认第一个
            self.city = self.cityArray.count?[self.cityArray firstObject]:@"";
            self.cityCode = self.cityCodeArray.count?[self.cityCodeArray firstObject]:@"";
        }

    } else {
        [self.myPicker reloadAllComponents];
        return;
    }
    
    //区
    if ([self.allDataJson[self.proviceIndex][@"citys"] count] <= self.cityIndex) {
        self.cityIndex = [self.allDataJson[self.proviceIndex][@"citys"] count] -1;
    }
    if ([self.allDataJson[self.proviceIndex][@"citys"][self.cityIndex][@"areas"] count]) {
        for (NSDictionary *areaDic in self.allDataJson[self.proviceIndex][@"citys"][self.cityIndex][@"areas"]) {
            [self.townArray addObject:areaDic[@"area"]];
            [self.townCodeArray addObject:areaDic[@"areaCode"]];
        }
        if ([NSString rj_stringIsEmpty:self.area]) {//未选择时默认第一个
            self.area = self.townArray.count?[self.townArray firstObject]:@"";
            self.areaCode = self.townCodeArray.count?[self.townCodeArray firstObject]:@"";
        }
    } else {
        [self.myPicker reloadAllComponents];
        return;
    }
    [self.myPicker reloadAllComponents];
}


-(void)setUpPikerView{
    
    self.maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 1;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    
    
    
    UIView *pickerBgView = [[UIView alloc]init];
    pickerBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.pickerBgView = pickerBgView;
    pickerBgView.frame = CGRectMake(0, 0, rj_kScreenWidth, 250);
    
    
    
    UIButton *btn1 = [[UIButton alloc]init];
    self.cancelBtn = btn1;
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(0, 0, 50, 40);
    [btn1 setTitleColor:rj_kColor_ff4b00 forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn1 addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerBgView addSubview:btn1];
    
    
    UIButton *btn2 = [[UIButton alloc]init];
    self.makeSureBtn =btn2;
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(rj_kScreenWidth - 50, 0,50 ,40);
    [btn2 setTitleColor:rj_kColor_ff4b00 forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn2 addTarget:self action:@selector(makeSureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerBgView addSubview:btn2];
    
    UILabel *titleL = [[UILabel alloc]init];
    self.titleLabel  = titleL;
    titleL.frame = CGRectMake(100, 0, 50, 40);
    titleL.grj_centerX = rj_kScreenWidth / 2;
    titleL.text = @"";
    titleL.font =[UIFont systemFontOfSize:13];
    titleL.textAlignment = NSTextAlignmentCenter;
    [self.pickerBgView addSubview:titleL];
    
    UIPickerView *pickerV= [[UIPickerView alloc]init];
    pickerV.delegate = self;
    pickerV.dataSource =self;
    self.myPicker = pickerV;
    pickerV.frame = CGRectMake(0, 40, rj_kScreenWidth, 250-30);
    pickerV.backgroundColor = [UIColor whiteColor];
    [self.pickerBgView addSubview:pickerV];
}

//滚动到指定行
- (void)scrollToPiceViewIndex {
    if (![NSString rj_stringIsEmpty:self.province]) {
        NSInteger value = [self.provinceArray indexOfObject:self.province];
        if (value < self.provinceArray.count) {
            [self.myPicker selectRow: value inComponent:0 animated:NO];
            self.proviceIndex = value;
        } else {
            self.province = @"";
            self.provinceCode = @"";
        }
        
        
        [self upDataAddressData];
    }
    
    if (![NSString rj_stringIsEmpty:self.city]) {
        NSInteger value = [self.cityArray indexOfObject:self.city];
        if (value < self.cityArray.count) {
            [self.myPicker selectRow: value inComponent:1 animated:NO];
            self.cityIndex = value;
        } else {
            self.city = @"";
            self.cityCode = @"";
        }
        
        [self upDataAddressData];
    }
    
    if (![NSString rj_stringIsEmpty:self.area]) {
        NSInteger value = [self.townArray indexOfObject:self.area];
        if (value < self.cityArray.count) {
            [self.myPicker selectRow: value inComponent:2 animated:NO];
            self.areaIndex = value;
        } else {
            self.area = @"";
            self.areaCode = @"";
        }
        
        [self upDataAddressData];
    }
}
/*********************************************************************************/
/*********************************************************************************/

#pragma mark - UIPicker Delegate
#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        if (row < self.provinceArray.count) {
            return [self.provinceArray objectAtIndex:row];
        } else {
            return @"";
        }
    } else if (component == 1) {
        if (row < self.cityArray.count) {
            return [self.cityArray objectAtIndex:row];
        } else {
            return @"";
        }
    } else {
        if (row < self.townArray.count) {
            return [self.townArray objectAtIndex:row];
        } else {
            return @"";
        }
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.proviceIndex = row;
    } else if (component == 1) {
        self.cityIndex = row;
    } else {
        self.areaIndex = row;
    }
    [self upDataAddressData];
    
    //获取数据
    NSInteger indexP = [pickerView selectedRowInComponent:0];
    self.province = indexP < self.provinceArray.count?[self.provinceArray objectAtIndex:indexP]:@"";
    self.provinceCode = indexP < self.provinceCodeArray.count?[self.provinceCodeArray objectAtIndex:indexP]:@"";
    
    NSInteger indexC = [pickerView selectedRowInComponent:1];
    self.city = indexC < self.cityArray.count?[self.cityArray objectAtIndex:indexC]:@"";
    self.cityCode = indexC < self.cityCodeArray.count?[self.cityCodeArray objectAtIndex:indexC]:@"";
    
    NSInteger indexA = [pickerView selectedRowInComponent:2];
    self.area = indexA < self.townArray.count?[self.townArray objectAtIndex:indexA]:@"";
    self.areaCode = indexA < self.townCodeArray.count?[self.townCodeArray objectAtIndex:indexA]:@"";
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return rj_kScreenWidth / 3 -30;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = rj_kColor_ff4b00;
        }
    }
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:self.font?:[UIFont systemFontOfSize:18]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - lazy loading
- (NSMutableArray *)provinceArray {
    
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _provinceArray;
}
- (NSMutableArray *)provinceCodeArray {
    
    if (!_provinceCodeArray) {
        _provinceCodeArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _provinceCodeArray;
}
- (NSMutableArray *)cityCodeArray {
    
    if (!_cityCodeArray) {
        _cityCodeArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _cityCodeArray;
}
- (NSMutableArray *)cityArray {
    
    if (!_cityArray) {
        _cityArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _cityArray;
}
- (NSMutableArray *)townArray {
    
    if (!_townArray) {
        _townArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _townArray;
}
- (NSMutableArray *)townCodeArray {
    
    if (!_townCodeArray) {
        _townCodeArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _townCodeArray;
}
@end
