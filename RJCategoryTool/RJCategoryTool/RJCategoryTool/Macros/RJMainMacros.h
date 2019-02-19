//
//  MainMacros.h
//  BMCityCon
//
//  Created by apple on 2018/12/18.
//  Copyright © 2018年 Global Barter. All rights reserved.
//

#ifndef MainMacros_h
#define MainMacros_h
/*********************屏幕适配*********************************/
#define rj_kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define rj_kScreenHeight         [[UIScreen mainScreen] bounds].size.height
#define rj_kScreenFrame          (CGRectMake(0, 0 ,kScreenWidth,kScreenHeight))
#define rj_kScreenSize           [UIScreen mainScreen].bounds.size
#define rj_kScreenNavHeight 64


//默认图片
//#define kPlaceholdImage [UIImage imageNamed:@"hobay_goods_none_image"]
#define rj_kPlaceholdHeadImage [UIImage imageNamed:@"mine_head_icon"]

// 设备型号
#define rj_DEVICE @"iphone"


//获取系统版本
#define rj_IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) ? YES : NO
#define rj_IOS7_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO
#define rj_IOS8_OR_LATER  [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending

//判断是否是Iphone5
//#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define rj_iPhone6P (kScreenHeight== 736)
#define rj_iPhone6 (kScreenHeight == 667)
#define rj_iPhone5 (kScreenHeight == 568)
#define rj_iPhone4 (kScreenHeight == 480)



/* 系统控件的默认高度 */
#define rj_StatusBarHeight   (20.f)
#define rj_NavBarHeight      (64.f)
#define rj_BottomBarHeight   (49.f)
#define rj_TopBarHeight      (IOS7_OR_LATER ? StatusBarHeight + NavBarHeight : NavBarHeight)
#define rj_ContentHeight     APP_HEIGHT - TopBarHeight - BottomBarHeight
#define rj_TableViewCellDefaultHeight (44.f)
#define rj_KeyboardHeightEnglish  (216.f)
#define rj_KeyboardHeightChinese  (252.f)


// 统一日志输出
#ifdef DEBUG  // 调试阶段
#define rj_Log(...) NSLog(__VA_ARGS__)
#define NSLog(...) NSLog(__VA_ARGS__)
#else // 发布阶段
#define rj_Log(...)
#define NSLog(...)
#endif

// 识别真机和模拟器
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

// ios7导航栏高度
#define rj_IOS7NavHeight  64

// 全局的appdelegate
#define rj_Delegate  ((AppDelegate *) [[UIApplication sharedApplication] delegate])

#define rj_Application [UIApplication sharedApplication]
// 通知
#define rj_NotificationCenter [NSNotificationCenter defaultCenter]


// 判断是否为物流商
#define rj_LOGISTICSLEVEL  ((NSString *) [[NSUserDefaults standardUserDefaults] objectForKey:IS_LOGISTICSLEVEL])



//版本
#define rj_SYSTEM_VERSION [[UIDevice currentDevice].systemVersion doubleValue]
#define rj_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//PNG JPG 图片路径
#define rj_PATH_PNG(NAME)      [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define rj_PATH_JPG(NAME)      [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define rj_EXPATH(NAME,EXT)      [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

//加载图片
#define rj_IMAGE_PNG(NAME)     [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define rj_IMAGE_JPG(NAME)     [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define rj_IMAGE(NAME,EXT)     [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

#define rj_IMAGE_NAMED(NAME)   [UIImage imageNamed:NAME]


//适配屏幕宽度、高度、间距、字体大小(以iPhone6为标准)(2017-9-26)
#define rj_kScreenWidthRatio  (rj_kScreenWidth /  375.0)
#define rj_kScreenHeightRatio (rj_kScreenHeight / 667.0)
//#define kScreenWidthRatio  (1)
//#define kScreenHeightRatio (1)
#define rj_AdaptedWidthValue(x)  (ceilf((x) * rj_kScreenWidthRatio))
#define rj_AdaptedHeightValue(x) (ceilf((x) * rj_kScreenHeightRatio))
#define rj_kSystemFontWithSize(R)     [UIFont systemFontOfSize:rj_AdaptedWidthValue(R)]//不再文字适配 2017-9-26
#define rj_kSystemFontWithBoldSize(R) [UIFont boldSystemFontOfSize:rj_AdaptedWidthValue(R)];//不再文字适配 2017-9-26


//当前版本
#define rj_CURRENT_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define rj_CHANNEL_NUMBER @"after2appstore"//渠道号 用于检测版本更新


#define iPhoneX [GBDeviceInfo deviceInfo].model == GBDeviceModeliPhoneX
#define rj_kIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//weakify && strongify
#define rj_weakify(var) __weak typeof(var) RJWeak_##var = var;
#define rj_strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = RJWeak_##var; \
_Pragma("clang diagnostic pop")

#endif /* MainMacros_h */
