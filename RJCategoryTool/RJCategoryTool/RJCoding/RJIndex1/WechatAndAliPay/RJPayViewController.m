//
//  RJPayViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJPayViewController.h"
#import "RJWechatAppPay.h"
#import "RJAlipayAppPay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface RJPayViewController ()
@property (strong ,nonatomic) NSArray *dataArray;

@property (strong ,nonatomic) UIButton *preButton;
@end
/*
 NSString* text = @"重要说明:\n本Demo为了方便向商户展示支付宝的支付流程，所以订单信息的加签过程放在客户端完成；\n在商户的真实App内，为了防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；\n商户privatekey等数据严禁放在客户端，订单信息的加签过程也务必放在服务端完成；\n若商户接入时不遵照此说明，因此造成了损失，需自行承担。";
 */
@implementation RJPayViewController
-(void)sureButtonActin{
    if (self.preButton) {
        switch (self.preButton.tag) {
            case 0: {
                [RJWechatAppPay pay];
            }
                break;
            case 1: {
                [RJAlipayAppPay pay];
            }
                break;
            case 2: {
                [self wechatServerPay];
            }
                break;
            case 3: {
                [self alipayServerPay];
            }
                break;
            default:
                break;
        }
    }else{
        [HUDManager showBriefAlert:@"请选择支付方式"];
    }
}
-(void)wechatServerPay{
    NSDictionary *responseObject = [NSDictionary dictionary];
    NSDictionary *weixinPayXml = [responseObject objectForKey:@"weixinPayXml"];
    
    PayReq *request   = [[PayReq alloc] init];
    
    request.partnerId = [weixinPayXml objectForKey:@"partnerId"];
    
    if (![[weixinPayXml objectForKey:@"prepayId"] isKindOfClass:[NSNull class]]) {
        request.prepayId= [weixinPayXml objectForKey:@"prepayId"];
    }
    request.package   = @"Sign=WXPay";
    
    request.nonceStr  = [weixinPayXml objectForKey:@"nonceStr"];
    
    NSString *timeStamp = [weixinPayXml objectForKey:@"timeStamp"];
    request.timeStamp = [timeStamp intValue];
    
    request.sign      = [weixinPayXml objectForKey:@"sign"];
    
    [WXApi sendReq:request completion:^(BOOL success) {
        
    }];
}
-(void)alipayServerPay{
    NSDictionary *responseObject = [NSDictionary dictionary];
    
    NSString *appScheme = @"com.transcity1314525.www";
    NSString *orderInfo = responseObject[@"payOrder"];
    [[AlipaySDK defaultService] payOrder:orderInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSLog(@"reslut = %@",resultDic);
        NSLog(@"%@",[resultDic objectForKey:@"memo"]);
        
    }];
    /*
     {
     "partner=\"2019053065374785\"&seller_id=\"huxipei@hobay.cn\"&out_trade_no=\"TR-2019060321071100133064\"&subject=\"焕呗平台\"&body=\"焕呗订单\"&total_fee=\"98.00\"&notify_url=\"http://api.hobay.cn/ribbon-api/pay/no_alipayNotify\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&return_url=\"m.alipay.com\"&sign=\"KHnpd%2BGYobpZ8C8aLscbovHy5ckam56MWfCij2oqk2kwEBlO4Do1frqbX4uZIykjnQaQfRSGvX50iTP3OJppb%2BFipAPYTbhbGSjrHZADPso5ATJ2bznUlwOD0iikTzIXmhAqtQTmpkJMPDukA4EPoEEeN732Srn9oPVS1ZlEIc5Ui9VwsmbU26mWx86tLWC4xd6m8hZ2pXFkNVobnTSsKO7OtCHwVKRTaJ8cXZxTOF46Ze%2FR4SKosQp0uxSiHRhALJooVgtHU5dbiT52ZDIDX4TqvSrY1L5aA9MOUryZgEG7FQsgADacqmIoFympQH9aRlgT10HlJqq93pKGtJ7JeQ%3D%3D\"&sign_type=\"RSA\""
     
     
     payOrder = "alipay_sdk=alipay-sdk-java-3.4.27.ALL&app_id=2019053065374785&biz_content=%7B%22body%22%3A%22App%E6%94%AF%E4%BB%98%22%2C%22out_trade_no%22%3A%22baimo-2019-06-03-01%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%22%E7%99%BE%E9%99%8C%E6%94%AF%E4%BB%98%22%2C%22timeout_express%22%3A%2260m%22%2C%22total_amount%22%3A%220.01%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&sign=KHnpd%2BGYobpZ8C8aLscbovHy5ckam56MWfCij2oqk2kwEBlO4Do1frqbX4uZIykjnQaQfRSGvX50iTP3OJppb%2BFipAPYTbhbGSjrHZADPso5ATJ2bznUlwOD0iikTzIXmhAqtQTmpkJMPDukA4EPoEEeN732Srn9oPVS1ZlEIc5Ui9VwsmbU26mWx86tLWC4xd6m8hZ2pXFkNVobnTSsKO7OtCHwVKRTaJ8cXZxTOF46Ze%2FR4SKosQp0uxSiHRhALJooVgtHU5dbiT52ZDIDX4TqvSrY1L5aA9MOUryZgEG7FQsgADacqmIoFympQH9aRlgT10HlJqq93pKGtJ7JeQ%3D%3D&sign_type=RSA2&timestamp=2019-06-03+21%3A03%3A08&version=1.0";
     }
     
     {
     "state": "success",
     "message": null,
     "results": {
     "page": "partner=\"2088721012115563\"&seller_id=\"huxipei@hobay.cn\"&out_trade_no=\"TR-2019060321071100133064\"&subject=\"焕呗平台\"&body=\"焕呗订单\"&total_fee=\"98.00\"&notify_url=\"http://api.hobay.cn/ribbon-api/pay/no_alipayNotify\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&return_url=\"m.alipay.com\"&sign=\"X4TUdtJucN9UcGb33NslLqw3%2Fx9WZ8WQ1SfA2Q18rC6%2F6yKvqshlqpPC0%2F9vk0UmgPAn%2BPIIqp0ewNdJn%2BUhnmCma0Lxqr5N%2BJNeCt%2B9gcGJYWkJ92Hd3qFWCammDUAwLSZd7YRE2HjYUEuMAizynmzhIdBgHD7mx%2BDoOO2%2FGN8%3D\"&sign_type=\"RSA\""
     }
     }
     */
}


-(void)payStyleSeleced:(UIButton *)sender{
    self.preButton.selected = NO;
    self.preButton = sender;
    self.preButton.selected = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付";
    
    UIView *view1 =[self setSubviewWithIndex:0];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(65);
    }];
    
    UIView *view2 =[self setSubviewWithIndex:1];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(65);
    }];
    
    UIView *view3 =[self setSubviewWithIndex:2];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(65);
    }];
    
    UIView *view4 =[self setSubviewWithIndex:3];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(65);
    }];
    
    RJSureButton *surebutton = [[RJSureButton alloc]initWithFrame:CGRectZero target:self action:@selector(sureButtonActin) title:@"立即支付"];
    [self.view addSubview:surebutton];
    [surebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(60);
        make.right.equalTo(self.view).offset(-60);
        make.height.mas_equalTo(rj_kNormalButtonHeight);
        make.top.equalTo(view4.mas_bottom).offset(150);
    }];
    
}
-(UIView *)setSubviewWithIndex:(NSInteger)index{
    UIView *contentView = [RJInitViewTool rj_initLineViewWithSuperView:self.view backgroundColor:rj_kColor_ffffff];
    [self.view addSubview:contentView];
    UIImageView *imageView = [RJInitViewTool rj_initImageViewWithSuperView:contentView];
    imageView.image = rj_IMAGE_NAMED(self.dataArray[index][@"image"]);
    UILabel *label  = [RJInitViewTool rj_initLabelWithSuperView:contentView text:self.dataArray[index][@"name"] font:rj_kFont_28 textColor:rj_kColor_333333];
    UIView *lineView = [RJInitViewTool rj_initLineViewWithSuperView:contentView backgroundColor:rj_kColor_eeeeee];
    UIButton *selButton = [RJInitViewTool rj_initImageButtonWithSuperView:contentView normal:@"third_gouxuan_no" selectedImageName:@"third_gouxuan" target:self action:@selector(payStyleSeleced:)];
    selButton.tag = index;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.left.equalTo(contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageView);
        make.left.equalTo(imageView.mas_right).offset(15);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView);
        make.bottom.equalTo(contentView);
        make.left.equalTo(contentView).offset(20);
        make.height.mas_equalTo(0.5);
    }];
    [selButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.right.equalTo(contentView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    return contentView;
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@{@"name":@"微信支付(前端)"  ,@"image":@"third_wechatpay"},
                       @{@"name":@"支付宝支付(前端)",@"image":@"third_alipay"},
                       @{@"name":@"微信支付(后端)"  ,@"image":@"third_wallet_wechat"},
                       @{@"name":@"支付宝支付(后端)" ,@"image":@"third_wallet_alipay"}];
    }
    return _dataArray;
}

@end
