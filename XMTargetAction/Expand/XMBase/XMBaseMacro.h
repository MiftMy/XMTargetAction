//
//  XMBaseMacro.h
//  XMAppAuthorization
//
//  Created by mifit on 2018/5/7.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#ifndef XMBaseMacro_h
#define XMBaseMacro_h

//自定义LOG
#define LOG_ON_FLAG 1
#if LOG_ON_FLAG
    #define DLog(...) NSLog(__VA_ARGS__)
#else
    #define DLog(...)
#endif

//屏宽高
#define XMSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define XMSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


//版本  当前版本、版本比较
#define XMSYSTEM_VERSION ([[[UIDevice currentDevice]systemVersion] floatValue])
#define XMSYSTEM_VERSION_BIGTHAN(othVersion) ((othVersion) <= ([[[UIDevice currentDevice]systemVersion] floatValue]))


//目录   home、tem、docments、caches
#define XMHOME_PATH (NSHomeDirectory())
#define XMTEM_PATH (NSTemporaryDirectory())
#define XMDOCUMENT_PATH (NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0])
#define XMCACHES_PATH (NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0])


//颜色  Color
#define XMTOAST_COLOR ([UIColor redColor].CGColor)
#define XMCOLOR_RGB(r,g,b) ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)])
#define XMCOLOR_RGBA(r,g,b,a) ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f])
#define XMNGreenColor ([UIColor colorWithRed:51/255.0f green:116/255.0f blue:37/255.0f alpha:1.0f])
#define XMNBlueColor ([UIColor colorWithRed:100/255.0f green:5/255.0f blue:255/255.0f alpha:1.0f])

//时间戳   当前时间->时间戳   时间戳->NSDate
#define XMTIMEINTERVAL ([[NSDate new] timeIntervalSince1970])
#define XMDATE_FROM_INTERVAL(val) ([NSDate dateWithTimeIntervalSince1970:val])

//应用支持最低、最高版本
//__IPHONE_OS_VERSION_MIN_REQUIRED
//__IPHONE_OS_VERSION_MAX_ALLOWED


#endif /* XMBaseMacro_h */


