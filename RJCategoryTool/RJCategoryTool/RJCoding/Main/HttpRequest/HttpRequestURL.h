//
//  HttpRequestURL.h
//  RJCategoryTool
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#ifndef HttpRequestURL_h
#define HttpRequestURL_h

#define kMyHttpEXCEPTION   @"网络异常,请检查网络!"
#define kMyHttpNOSERVER    @"服务器正在维护!"

#define kMyHttpTIMEOUT     @"请求超时!"
#define kMyHttpFAILED      @"获取数据失败,请稍后重试!"
#define kMyHttpOTHERFAILED @"异常"//@"Are you kidding me?"//@"其他错误!"
#define kMyHttpOTHERERROR  @"ERROR!"


#define kUserToken  @""
#define kRJPlaceholderImage [UIImage imageNamed:@"rj_flower_icon"];

//1.5版本开发
/************************  正式环境  ******************************/
#if DEBUG
#define kMyHttpBaseURL             @"http://47.100.204.195:8089/"
#else
#define kMyHttpBaseURL             @"http://api.baimokc.com/"
#endif

#endif /* HttpRequestURL_h */
