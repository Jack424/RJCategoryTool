//
//  ViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/2/14.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import "ViewController.h"


//支付宝支付
#import <AlipaySDK/AlipaySDK.h>
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import "APAuthInfo.h"


//微信支付
#import <WechatOpenSDK/WXApi.h>
#import "CommonUtil.h"
#import "GDataXMLNode.h"

@interface ViewController ()

@end

@implementation ViewController
/*
 NSString* text = @"重要说明:\n本Demo为了方便向商户展示支付宝的支付流程，所以订单信息的加签过程放在客户端完成；\n在商户的真实App内，为了防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；\n商户privatekey等数据严禁放在客户端，订单信息的加签过程也务必放在服务端完成；\n若商户接入时不遵照此说明，因此造成了损失，需自行承担。";
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    RJSureButton *wechatPayButton = [[RJSureButton alloc]initWithFrame:CGRectZero target:self action:@selector(wechatPay) title:@"微信支付"];
    [self.view addSubview:wechatPayButton];
    [wechatPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(50);
        make.height.mas_equalTo(rj_kNormalButtonHeight);
    }];
    
    RJSureButton *aliPayButton = [[RJSureButton alloc]initWithFrame:CGRectZero target:self action:@selector(aliPay) title:@"支付宝支付"];
    [self.view addSubview:aliPayButton];
    [aliPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(wechatPayButton.mas_bottom).offset(20);
        make.height.mas_equalTo(rj_kNormalButtonHeight);
    }];
}



/**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/
/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
NSString * const WXAppId = @"wx7af7e2c0d9c9da8b";

/**
 *  申请微信支付成功后，发给你的邮件里的微信支付商户号
 */
NSString * const WXPartnerId = @"1451831002";

/** API密钥 去微信商户平台设置--->账户设置--->API安全， 参与签名使用 */
NSString * const WXAPIKey = @"effe1e5eb476da14f7c4aa6f096c86aa";

/** 获取prePayId的url, 这是官方给的接口 */
NSString * const getPrePayIdUrl = @"https://api.mch.weixin.qq.com/pay/unifiedorder";

-(void)wechatPay{
    [self getWeChatPayWithOrderName:@"商品名字" price:@"1"];
}

// 调起微信支付，传进来商品名称和价格
- (void)getWeChatPayWithOrderName:(NSString *)name
                            price:(NSString*)price

{
    
    //----------------------------获取prePayId配置------------------------------
    // 订单标题，展示给用户
    NSString* orderName = name;
    // 订单金额,单位（分）, 1是0.01元
    NSString* orderPrice = price;
    // 支付类型，固定为APP
    NSString* orderType = @"APP";
    // 随机数串
    NSString *noncestr  = [self genNonceStr];
    // 商户订单号
    NSString *orderNO   = [self genOutTradNo];
    
    //================================
    //预付单参数订单设置
    //================================
    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
    
    [packageParams setObject: WXAppId      forKey:@"appid"];       //开放平台appid
    [packageParams setObject: WXPartnerId  forKey:@"mch_id"];      //商户号
    [packageParams setObject: noncestr     forKey:@"nonce_str"];   //随机串
    [packageParams setObject: orderType    forKey:@"trade_type"];  //支付类型，固定为APP
    [packageParams setObject: orderName    forKey:@"body"];        //订单描述，展示给用户
    [packageParams setObject: orderNO      forKey:@"out_trade_no"];//商户订单号
    [packageParams setObject: orderPrice   forKey:@"total_fee"];   //订单金额，单位为分
    [packageParams setObject: [CommonUtil getIPAddress:YES] forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: @"http://weixin.qq.com"  forKey:@"notify_url"];  //支付结果异步通知
    NSString *prePayid;
    
    /// ****     获取prePayId    ************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
    prePayid = [self sendPrepay:packageParams];
    //---------------------------获取prePayId结束------------------------------
    
    
    
    
    
    if(prePayid){
        /****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
        NSString *timeStamp = [self genTimeStamp];
        // 调起微信支付
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = WXPartnerId;
        request.prepayId = prePayid;
        request.package = @"Sign=WXPay";
        request.nonceStr = noncestr;
        request.timeStamp = [timeStamp intValue];
        
        // 这里要注意key里的值一定要填对， 微信官方给的参数名是错误的，不是第二个字母大写
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: WXAppId               forKey:@"appid"];
        [signParams setObject: WXPartnerId           forKey:@"partnerid"];
        [signParams setObject: request.nonceStr      forKey:@"noncestr"];
        [signParams setObject: request.package       forKey:@"package"];
        [signParams setObject: timeStamp             forKey:@"timestamp"];
        
        NSLog(@"++++++%@",request.prepayId );
        [signParams setObject: request.prepayId      forKey:@"prepayid"];
        
        //生成签名
        /****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
        
        
        NSString *sign  = [self genSign:signParams];
        NSLog(@"++++--------++%@",sign );
        //添加签名
        request.sign = sign;
        
        [WXApi sendReq:request];
        
        
    } else{
        NSLog(@"获取prePayId失败！");
    }
    
    
    
}

// 发送给微信的XML格式数据
- (NSString *)genPackage:(NSMutableDictionary*)packageParams
{
    NSString *sign;
    NSMutableString *reqPars = [NSMutableString string];
    
    // 生成签名
    /****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
    sign = [self genSign:packageParams];
    
    // 生成xml格式的数据, 作为post给微信的数据
    NSArray *keys = [packageParams allKeys];
    [reqPars appendString:@"<xml>"];
    for (NSString *categoryId in keys) {
        [reqPars appendFormat:@"<%@>%@</%@>"
         , categoryId, [packageParams objectForKey:categoryId],categoryId];
    }
    [reqPars appendFormat:@"<sign>%@</sign></xml>", sign];
    
    return [NSString stringWithString:reqPars];
}




// 获取prePayId
- (NSString *)sendPrepay:(NSMutableDictionary *)prePayParams
{
    
    // 获取提交预支付的xml格式数据
    /****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
    NSString *send = [self genPackage:prePayParams];
    // 打印检查， 格式应该是xml格式的字符串
    NSLog(@"获取提交预支付的xml格式数据----%@", send);
    
    // 转换成NSData
    NSData *data_send = [send dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:getPrePayIdUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data_send];
    
    NSError *error = nil;
    // 拿到data后, 用xml解析， 这里随便用什么方法解析
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSLog(@"data解析 ---- %@",data);
    if (!error) {
        // 1.根据data初始化一个GDataXMLDocument对象
        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
        
        
        NSLog(@"根据data初始化一个GDataXMLDocument对象 ----%@",document);
        // 2.拿出根节点
        GDataXMLElement *rootElement = [document rootElement];
        GDataXMLElement *return_code = [[rootElement elementsForName:@"return_code"] lastObject];
        GDataXMLElement *return_msg = [[rootElement elementsForName:@"return_msg"] lastObject];
        GDataXMLElement *result_code = [[rootElement elementsForName:@"result_code"] lastObject];
        GDataXMLElement *prepay_id = [[rootElement elementsForName:@"prepay_id"] lastObject];
        // 如果return_code和result_code都为SUCCESS, 则说明成功
        NSLog(@"return_code---%@", [return_code stringValue]);
        // 返回信息，通常返回一些错误信息
        NSLog(@"return_msg---%@", [return_msg stringValue]);
        NSLog(@"result_code---%@", [result_code stringValue]);
        // 拿到这个就成功一大半啦
        NSLog(@"prepay_id---%@", [prepay_id stringValue]);
        
        return [prepay_id stringValue];
    } else {
        return nil;
    }
}

#pragma mark - 生成各种参数

- (NSString *)genTimeStamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

/**
 * 注意：商户系统内部的订单号,32个字符内、可包含字母,确保在商户系统唯一
 */
- (NSString *)genNonceStr
{
    return [CommonUtil md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}

/**
 * 建议 traceid 字段包含用户信息及订单信息，方便后续对订单状态的查询和跟踪
 */
- (NSString *)genTraceId
{
    /****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
    return [NSString stringWithFormat:@"myt_%@", [self genTimeStamp]];
}

- (NSString *)genOutTradNo
{
    return [CommonUtil md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}


#pragma mark - 签名
/** 签名 */
- (NSString *)genSign:(NSDictionary *)signParams
{
    // 排序, 因为微信规定 ---> 参数名ASCII码从小到大排序
    NSArray *keys = [signParams allKeys];
    NSLog(@"KKKKKKKKKKKKKKKKKKKK++++++++++++++%@",keys);
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSLog(@"KKKKKKKKKKKKKKKKKKKK==========%@",sortedKeys);
    //生成 ---> 微信规定的签名格式
    NSMutableString *sign = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [sign appendString:key];
        [sign appendString:@"="];
        [sign appendString:[signParams objectForKey:key]];
        [sign appendString:@"&"];
    }
    NSLog(@"KKKKKKKKKKKKKKKKKKKK======-----====%@KKKKKKKKKKKKKKKKKKKK======-----====",sign);
    
    NSString *signString = [[sign copy] substringWithRange:NSMakeRange(0, sign.length - 1)];
    
    // 拼接API密钥
    NSString *result = [NSString stringWithFormat:@"%@&key=%@", signString, WXAPIKey];
    // 打印检查
    NSLog(@"result = %@", result);
    // md5加密
    NSString *signMD5 = [CommonUtil md5:result];
    // 微信规定签名英文大写
    signMD5 = signMD5.uppercaseString;
    // 打印检查
    NSLog(@"signMD5 = %@", signMD5);
    return signMD5;
}









/**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/  /**********************************/


-(void)aliPay{
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2016092700610844";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCQa5vfoT3foQ5O4qI47yNQOnbdoM9WVMXReVCh3ITTDJAeDBAA6AyMcCku4+wSHV0RaozWKutc7UmFPZRqXv7ahqr7yDu8QCkoUHZeWnXWH2cMN85Uu1/dFkH4cgB+dbc6KUpnpnAuhSZ+wEVNNqWzPhBULsdg7lpb7+S4mtqaOzSAGPeN0Lb+9VUhddHTV8bDQ4E+35cg/sDFInUkveCIotcdQei3a6tyao6nordYdxs3vstythRA4giKzXSdbb97D1pEv+h8BoWeBOiTGMvNwM9yld3gUCt17g9XBLwgm1UIGZkRJ2zF9J5An3TWq+Gkg9jxb+04HD+/5qAUIHPHAgMBAAECggEADe8D6/CPmqrcSYoeIqYX3x605y8jse2d5FbzC5rOCdq1cOCzDpNU2pvbrVV6KklA+HQyQFuFt8KBDGTjk9u0dPr3NjGcac466lPRB8tsgQsokwozUwN8/USvervtBkZvNiJTtmpdem+IRkRgq1FxbTi4tJaKz/RPLX2YsKLoImccy3Ehixa6WRmxHwA4DM9dxBWAPJwi58GLTxNXKwSILx2Ljoj/fhohMLpBTcm6EDOV/VqpaeMNxMMTYkm3p3iaal0bYMDoc8okKEml11XuXQ4ktgim7+kyBAtT6Sug3k/oR9qDqOl4N0S3+rRw/8aXOmhxOeEp4RMfZpmdDXuWQQKBgQDGguFqC9ZmB3m0QCs0YVYl7DoywM0Xl6E0CLxTMXqTVsEQ2hY9zQL/zakZj9ILH05hH1GfFdsgiCH233H9qNOrzUgW0N4f5iSe+x/exEB6Z23kgS5y23nid1sqtdSsrvJE6dmV3Bj0UcD03tUsc4bYbgi+aeN1OgJu+eHrpoj05wKBgQC6PpDy60YXKHiAgLdHxgARAvQ9hh0015vbVjlDVm2P2dVbsnJ6fTCf3hue9Hf4tNIoYn3SqVtkHxFHvtPVzyQPwL7kozMnf9+3ffAWCSfYygXrtH8lCMym9I9ARbSdEf+Zs/rMnQWt/Q0G49u0RtH/LAxtO0uy+P/YEonXKYHOIQKBgBfcAUXiuFk5Csq8b7TzAgy60N/qxnvQcMK1ThVdvBLbeYcR/1xcOMEQMgPtglxt3djUj9XkJZtKYXKvtp67XP2oRcLgReJlof8txc3bnrhXmCC/2hpaANNUbzO5+R7sRBg+VzWo56Lt9Jg59DtMg2eeChUA2yLq3wIBrMLLGGj/AoGBAJJCjjxm7b1ECBYKf2S7JtQ1OK+UQh18cSZ3+TJbjmEY1chURDjTVbtGhvR20jybbCtQ5bTpUR84kq6AOwW+zXgdiwws6gBMGNmV6lSzzfoe9TVcozjnRyiaCGGWHDf5qXwAbqX/bjVr864EhUZ3E3VMF1o05cbgarM6I8u4CfthAoGBAJhYSIUUdAIQSh37Jou9QLVIcgEloEJwdszzBG6M8szYgR11ScGH7K9V5jDEXdBKn5IXnFnGNogZMTbnOkNmsO+tG764noug5VRgrIKs8KFjztAeBI/xKZyEULitS4fy1MhNMA5P0Qn0olTRTDjdlGFk3Nrhp7vp4ZYHp/sNcmC1";
    NSString *rsaPrivateKey = @"";
    
    /*
     公钥
     
     
     私钥2
     
     */
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少appId或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"com.grj.RJCategoryTool";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}
#pragma mark -
#pragma mark   ==============点击模拟授权行为==============

- (void)doAPAuth
{
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *pid = @"";
    NSString *appID = @"";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //pid和appID获取失败,提示
    if ([pid length] == 0 ||
        [appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少pid或者appID或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    //生成 auth info 对象
    APAuthInfo *authInfo = [APAuthInfo new];
    authInfo.pid = pid;
    authInfo.appID = appID;
    
    //auth type
    NSString *authType = [[NSUserDefaults standardUserDefaults] objectForKey:@"authType"];
    if (authType) {
        authInfo.authType = authType;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    // 将授权信息拼接成字符串
    NSString *authInfoStr = [authInfo description];
    NSLog(@"authInfoStr = %@",authInfoStr);
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:authInfoStr withRSA2:YES];
    } else {
        signedString = [signer signString:authInfoStr withRSA2:NO];
    }
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    if (signedString.length > 0) {
        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, ((rsa2PrivateKey.length > 1)?@"RSA2":@"RSA")];
        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr
                                         fromScheme:appScheme
                                           callback:^(NSDictionary *resultDic) {
                                               NSLog(@"result = %@",resultDic);
                                               // 解析 auth code
                                               NSString *result = resultDic[@"result"];
                                               NSString *authCode = nil;
                                               if (result.length>0) {
                                                   NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                   for (NSString *subResult in resultArr) {
                                                       if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                           authCode = [subResult substringFromIndex:10];
                                                           break;
                                                       }
                                                   }
                                               }
                                               NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                           }];
    }
}


#pragma mark -
#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


@end
