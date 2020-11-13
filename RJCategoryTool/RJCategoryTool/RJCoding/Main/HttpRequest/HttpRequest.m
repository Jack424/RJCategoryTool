//
//  HttpRequest.m
//  BMTransCity
//
//  Created by apple on 2019/5/20.
//  Copyright © 2019 JinTian. All rights reserved.
//

#import "HttpRequest.h"

typedef NS_ENUM(NSInteger,HttpRequestSerializerType) {
    HttpRequestSerializerTypeHTTP,
    HttpRequestSerializerTypeJSON
};

typedef NS_ENUM(NSInteger,HttpRequestType) {
    HttpRequestTypeGet,
    HttpRequestTypePOST,
    HttpRequestTypePUT,
    HttpRequestTypeDELETE
};

#define HttpRequestTIMEOUTINTERVAL 30.0f;

static dispatch_once_t predicate;
@interface HttpRequest ()
@property (nonatomic,strong)    AFHTTPSessionManager *manager;

@end
@implementation HttpRequest
/**
 GET
 */
+ (void)getHTTPWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success   failure:(httpFailureBlock)failure{
    [HttpRequest httpRequestWithSerializerType:HttpRequestSerializerTypeHTTP requestType:HttpRequestTypeGet URL:urlStr parameter:parameter hcHUDView:view success:success   failure:failure];
    
}
+(void)getJSONWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success   failure:(httpFailureBlock)failure{
    [HttpRequest httpRequestWithSerializerType:HttpRequestSerializerTypeJSON requestType:HttpRequestTypeGet URL:urlStr parameter:parameter hcHUDView:view success:success   failure:failure];
}
/**
 POST
 */
+ (void)postHTTPWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success   failure:(httpFailureBlock)failure{
    [HttpRequest httpRequestWithSerializerType:HttpRequestSerializerTypeHTTP requestType:HttpRequestTypePOST URL:urlStr parameter:parameter hcHUDView:view success:success   failure:failure];
    
}
+(void)postJSONWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success   failure:(httpFailureBlock)failure{
    [HttpRequest httpRequestWithSerializerType:HttpRequestSerializerTypeJSON requestType:HttpRequestTypePOST URL:urlStr parameter:parameter hcHUDView:view success:success   failure:failure];
}
/**
 PUT
 */
+ (void)putHTTPWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success   failure:(httpFailureBlock)failure{
    [HttpRequest httpRequestWithSerializerType:HttpRequestSerializerTypeHTTP requestType:HttpRequestTypePUT URL:urlStr parameter:parameter hcHUDView:view success:success   failure:failure];
    
}
+(void)putJSONWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success   failure:(httpFailureBlock)failure{
    [HttpRequest httpRequestWithSerializerType:HttpRequestSerializerTypeJSON requestType:HttpRequestTypePUT URL:urlStr parameter:parameter hcHUDView:view success:success   failure:failure];
}
/**
 DELETE
 */
+ (void)deleteHTTPWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success   failure:(httpFailureBlock)failure{
    [HttpRequest httpRequestWithSerializerType:HttpRequestSerializerTypeHTTP requestType:HttpRequestTypeDELETE URL:urlStr parameter:parameter hcHUDView:view success:success   failure:failure];
    
}
+(void)deleteJSONWithURL:(NSString *)urlStr parameter:(id)parameter hcHUDView:(UIView *)view success:(httpSuccessBlock)success   failure:(httpFailureBlock)failure{
    [HttpRequest httpRequestWithSerializerType:HttpRequestSerializerTypeJSON requestType:HttpRequestTypeDELETE URL:urlStr parameter:parameter hcHUDView:view success:success   failure:failure];
}





+ (void)httpRequestWithSerializerType:(HttpRequestSerializerType)serializerType
                          requestType:(HttpRequestType)requestType
                                  URL:(NSString *)urlStr
                            parameter:(id)parameter
                            hcHUDView:(UIView *)view
                              success:(httpSuccessBlock)success
                              failure:(httpFailureBlock)failure{
    [HttpRequest setBaseSettingWithSerializerType:serializerType];
    [HttpRequest logUrlWithAppendingString:urlStr];
    urlStr = [HttpRequest dealWithUrl:urlStr];
    if (view) {
        [HUDManager showHUDAddedToView:view];//开启HUD
    }
    switch (requestType) {
        case HttpRequestTypeGet:
        {
            [[HttpRequest shareInstance].manager GET:urlStr parameters:parameter headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [HttpRequest settingFailureDealWithResponseObject:responseObject hcHUDView:view success:success  ];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {//请求失败  网络异常
                    failure(error);
                    [HttpRequest settingFailureDealWithError:error hcHUDView:view];
                }
            }];
        }
            break;
        case HttpRequestTypePOST:
        {
            [[HttpRequest shareInstance].manager POST:urlStr parameters:parameter headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [HttpRequest settingFailureDealWithResponseObject:responseObject hcHUDView:view success:success  ];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {//请求失败  网络异常
                    failure(error);
                    [HttpRequest settingFailureDealWithError:error hcHUDView:view];
                }
            }];
        }
            break;
        case HttpRequestTypePUT:
        {
            [[HttpRequest shareInstance].manager PUT:urlStr parameters:parameter headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [HttpRequest settingFailureDealWithResponseObject:responseObject hcHUDView:view success:success  ];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {//请求失败  网络异常
                    failure(error);
                    [HttpRequest settingFailureDealWithError:error hcHUDView:view];
                }
            }];
        }
            break;
        case HttpRequestTypeDELETE:
        {
            [[HttpRequest shareInstance].manager DELETE:urlStr parameters:parameter headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [HttpRequest settingFailureDealWithResponseObject:responseObject hcHUDView:view success:success  ];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {//请求失败  网络异常
                    failure(error);
                    [HttpRequest settingFailureDealWithError:error hcHUDView:view];
                }
            }];
        }
            break;
        default:
            break;
    }
    
    
}
//请求设置
+(void)setBaseSettingWithSerializerType:(HttpRequestSerializerType)type{
    if (type==HttpRequestSerializerTypeHTTP) {
        [HttpRequest shareInstance].manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        [HttpRequest shareInstance].manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }else{
        [HttpRequest shareInstance].manager.requestSerializer  = [AFJSONRequestSerializer serializer];
        [HttpRequest shareInstance].manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    [HttpRequest shareInstance].manager.requestSerializer.timeoutInterval = HttpRequestTIMEOUTINTERVAL;//设置超时时间
    //接收类型不一致请替换一致text/html或别的
    [HttpRequest shareInstance].manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpeg",@"image/png",@"application/octet-stream",nil];
//    [[HttpRequest shareInstance].manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    [[HttpRequest shareInstance].manager.requestSerializer setValue:kUserToken forHTTPHeaderField:@"token"];
}
//成功的处理
+(void)settingFailureDealWithResponseObject:(id)responseObject hcHUDView:(UIView *)view success:(void (^)(id inSuccessData))success{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUDManager hideHUDForView:view];//关闭HUD
    });
    responseObject = [responseObject mj_JSONObject];
    
    if (success) {
        NSDictionary *resultsDict = [responseObject objectForKey:@"data"];
        NSLog(@"成功  ----- %@ ",resultsDict);
        //[HUDManager showBriefAlert:[responseObject objectForKey:@"msg"]];
        success(resultsDict);
    }
}

//失败的处理
+(void)settingFailureDealWithError:(NSError *)error hcHUDView:(UIView *)view{
    NSLog(@"失败  ----- %@ ",[error description]);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUDManager hideHUDForView:view];//关闭HUD
    });//关闭HUD
    if (error.code==NSURLErrorNotConnectedToInternet) {//网络异常提示
        [HUDManager showBriefAlert:kMyHttpEXCEPTION];
    }else if (error.code==NSURLErrorCannotConnectToHost){//服务器关闭
        [HUDManager showBriefAlert:kMyHttpNOSERVER];
    }else if (error.code==NSURLErrorTimedOut){//请求超时
        [HUDManager showBriefAlert:kMyHttpTIMEOUT];
    }else if (error.code==NSURLErrorCannotDecodeContentData){//token失效
        
    }else if (error.code==NSURLErrorBadServerResponse){//-1011
        NSHTTPURLResponse *response = error.userInfo[@"com.alamofire.serialization.response.error.response"];
        if (response.statusCode==401) {//用户过期
         
        }
        else if (response.statusCode==403) {
//            [HUDManager showBriefAlert:@"校验不通过"];
            NSDictionary *dictFromData = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"]
                                                                         options:NSJSONReadingAllowFragments                                                         error:&error];
            NSData *data =[dictFromData[@"message"] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];;
            
            NSArray *keys = [dataDict allKeys];
            if (keys.count>0) {
                [HUDManager showBriefAlert:dataDict[keys[0]]];
            }else{
                [HUDManager showBriefAlert:@"校验不通过"];
            }
        }
        else{
            NSDictionary *dictFromData = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"]
                                                                         options:NSJSONReadingAllowFragments                                                         error:&error];
            [HUDManager showBriefAlert:dictFromData[@"message"]];
        }
    }else{//网络异常提示
        [HUDManager showBriefAlert:kMyHttpOTHERFAILED];
    }
}
+(void)logUrlWithAppendingString:(NSString *)url{
    NSLog(@"%@",[kMyHttpBaseURL stringByAppendingString:url]);
}

+(NSString *)dealWithUrl:(NSString *)pathURL{
    pathURL = [pathURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([pathURL containsString:@"http"]) {
        pathURL = [pathURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"+#%<>[\\]^`{|}\"] "].invertedSet];
    }else{
        pathURL = [kMyHttpBaseURL stringByAppendingString: [pathURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"+#%<>[\\]^`{|}\"] "].invertedSet]];
    }
    return pathURL;
    
}



/**********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
+(void)cancelRequest{
    [[HttpRequest shareInstance].manager.tasks  makeObjectsPerformSelector:@selector(cancel)];
}
+(void)clear {
    predicate  = 0;
}
+(HttpRequest *)shareInstance{
    static HttpRequest* instance = nil;
    
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
    }
    return self;
}

@end
